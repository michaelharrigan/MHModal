//
//  MHModal.swift
//  MHModal
//
//  Created by Michael Harrigan on 11/1/24.
//
//
import SwiftUI
//
public struct MHModal<Content: View>: View {
  // MARK: - Properties
  @Binding private var isPresented: Bool
  private let content: Content
  private let configuration: MHModalConfiguration
  
  @State private var contentSize: CGSize = .zero
  @State private var dragOffset: CGFloat = 0
  @GestureState private var isDragging = false
  
  // MARK: - Initialization
  public init(
    isPresented: Binding<Bool>,
    configuration: MHModalConfiguration = MHModalConfiguration(),
    @ViewBuilder content: () -> Content
  ) {
    self._isPresented = isPresented
    self.configuration = configuration
    self.content = content()
  }
  private let springConfig = SpringAnimation(
    response: 0.35,  // Faster response
    dampingFraction: 0.7  // Less damping for more natural bounce
  )
  //
  private let dismissConfig = SpringAnimation(
    response: 0.28,  // Quick dismissal
    dampingFraction: 0.68  // Slight bounce on dismiss
  )
  // MARK: - Private Properties
  private var modalHeight: CGFloat {
    let screenHeight = UIScreen.main.bounds.height
    let maxDetentHeight = configuration.availableDetents
      .map { $0.heightMultiplier * screenHeight }
      .max() ?? screenHeight * 0.85
    
    return min(contentSize.height + topPadding, maxDetentHeight)
  }
  
  private var topPadding: CGFloat {
    configuration.showDragIndicator ? 37 : 0
  }
  
  private var dragAnimation: Animation {
    isDragging ? .interactiveSpring() : .spring(
      response: springConfig.response,
      dampingFraction: springConfig.dampingFraction
    )
  }
  
  // MARK: - Body
  public var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .bottom) {
        if isPresented {
          background
          modalContent(geometry: geometry)
        }
      }
    }
  }
  
  // MARK: - Private Views
  @ViewBuilder
  private var background: some View {
    Color.black
      .opacity(0.4 * (1.0 - min(Double(dragOffset) / 300.0, 1.0)))
      .ignoresSafeArea()
      .transition(.opacity.animation(.easeOut(duration: 0.2)))
      .onTapGesture {
        dismissModal()
      }
  }
  
  @ViewBuilder
  private func modalContent(geometry: GeometryProxy) -> some View {
    VStack(spacing: 0) {
      if configuration.showDragIndicator {
        dragIndicator
      }
      
      if contentSize.height > modalHeight {
        ScrollView {
          content
            .background(sizeReader)
        }
      } else {
        content
          .background(sizeReader)
      }
    }
    .frame(maxWidth: .infinity)
    .frame(height: modalHeight)
    .background(configuration.backgroundColor)
    .clipShape(RoundedRectangle(cornerRadius: configuration.cornerRadius, style: .continuous))
    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: -2)
    .padding(.horizontal, configuration.horizontalPadding)
    .padding(.bottom, configuration.bottomPadding)
    .offset(y: dragOffset)
    .animation(dragAnimation, value: dragOffset)
    .gesture(configuration.enableDragToDismiss ? dragGesture : nil)
    .transition(modalTransition)
  }
  
  @ViewBuilder
  private var dragIndicator: some View {
    RoundedRectangle(cornerRadius: 2.5)
      .fill(configuration.dragIndicatorColor)
      .frame(width: 36, height: 5)
      .padding(.top, 12)
      .padding(.bottom, 20)
  }
  
  @ViewBuilder
  private var sizeReader: some View {
    GeometryReader { proxy in
      Color.clear
        .preference(key: SizePreferenceKey.self, value: proxy.size)
    }
    .onPreferenceChange(SizePreferenceKey.self) { size in
      contentSize = size
    }
  }
  
  // MARK: - Gestures and Animations
  private var dragGesture: some Gesture {
    DragGesture()
      .updating($isDragging) { _, state, _ in
        state = true
      }
      .onChanged { value in
        dragOffset = calculateDragOffset(value.translation.height)
      }
      .onEnded { value in
        handleDragEnd(value)
      }
  }
  
  private func calculateDragOffset(_ translation: CGFloat) -> CGFloat {
    if translation < 0 {
      return -sqrt(abs(translation)) * 4
    } else {
      return translation * 0.7
    }
  }
  
  private func handleDragEnd(_ value: DragGesture.Value) {
    let velocity = value.predictedEndLocation.y - value.location.y
    let shouldDismiss = value.translation.height > 100 || velocity > 170
    
    if shouldDismiss {
      dismissModal()
    } else {
      withAnimation(dragAnimation) {
        dragOffset = 0
      }
    }
  }
  
  private func dismissModal() {
    withAnimation(.spring(
      response: dismissConfig.response,
      dampingFraction: dismissConfig.dampingFraction
    )) {
      isPresented = false
    }
  }
  
  private var modalTransition: AnyTransition {
    .asymmetric(
      insertion: .opacity
        .combined(with: .move(edge: .bottom))
        .combined(with: .scale(scale: 0.93, anchor: .bottom))
        .animation(.spring(response: 0.45, dampingFraction: 0.8)),
      removal: .opacity
        .combined(with: .move(edge: .bottom))
        .animation(.spring(
          response: dismissConfig.response,
          dampingFraction: dismissConfig.dampingFraction
        ))
    )
  }
}
