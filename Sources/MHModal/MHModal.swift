//
//  MHModal.swift
//  MHModal
//
//  Created by Michael Harrigan on 11/1/24.
//
//
import SwiftUI

/// A customizable modal view that can be presented and dismissed with various animations and interactions.
///
/// `MHModal` provides a flexible way to present content in a modal fashion, with support for:
/// - Custom content
/// - Drag-to-dismiss gesture
/// - Configurable appearance and behavior
/// - Adaptive height based on content
/// - Smooth animations for presentation and dismissal
///
/// Example usage:
/// ```swift
/// struct ContentView: View {
///     @State private var showModal = false
///
///     var body: some View {
///         Button("Show Modal") {
///             showModal = true
///         }
///         .mhModal(isPresented: $showModal) {
///             Text("Modal Content")
///                 .padding()
///         }
///     }
/// }
/// ```
public struct MHModal<Content: View>: View {
  // MARK: - Properties
  @Binding private var isPresented: Bool
  private let content: Content
  private let configuration: MHModalConfiguration

  @State private var contentSize: CGSize = .zero
  @State private var dragOffset: CGFloat = 0
  @GestureState private var isDragging = false
  
  // MARK: - Initialization
  
  /// Creates a new instance of `MHModal` with the specified parameters.
  ///
  /// - Parameters:
  ///   - isPresented: A binding to a Boolean value that determines whether the modal is currently presented.
  ///   - configuration: The configuration options for the modal. Defaults to `MHModalConfiguration.default()`.
  ///   - content: A closure that returns the content view to be displayed within the modal.
  public init(
    isPresented: Binding<Bool>,
    configuration: MHModalConfiguration = MHModalConfiguration.default(),
    @ViewBuilder content: () -> Content
  ) {
    self._isPresented = isPresented
    self.configuration = configuration
    self.content = content()
  }
  
  /// Configuration for the spring animation used when the modal is dragged.
  private let springConfig = SpringAnimation(
    response: 0.35,  // Faster response
    dampingFraction: 0.7  // Less damping for more natural bounce
  )
  
  /// Configuration for the spring animation used when the modal is dismissed.
  private let dismissConfig = SpringAnimation(
    response: 0.28,  // Quick dismissal
    dampingFraction: 0.68  // Slight bounce on dismiss
  )
  
  // MARK: - Private Properties
  
  /// Calculates the height of the modal based on content size and available detents.
  private var modalHeight: CGFloat {
    let screenHeight = UIScreen.main.bounds.height
    let maxDetentHeight = configuration.availableDetents
      .map { $0.heightMultiplier * screenHeight }
      .max() ?? screenHeight * 0.85
    
    return min(contentSize.height + topPadding, maxDetentHeight)
  }
  
  /// Determines the top padding of the modal content.
  private var topPadding: CGFloat {
    configuration.showDragIndicator ? 37 : 0
  }
  
  /// Provides the appropriate animation for dragging the modal.
  private var dragAnimation: Animation {
    isDragging ? .interactiveSpring() : .spring(
      response: springConfig.response,
      dampingFraction: springConfig.dampingFraction
    )
  }
  
  // MARK: - Body
  
  /// The body of the `MHModal` view.
  public var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .bottom) {
        if isPresented {
          contentOverlay
          modalContent(geometry: geometry)
        }
      }
    }
  }
  
  // MARK: - Private Views
  
  /// Creates the semi-transparent background for the modal.
  @ViewBuilder
  private var contentOverlay: some View {
    configuration.contentOverlayColor
      .opacity(0.4 * (1.0 - min(Double(dragOffset) / 300.0, 1.0)))
      .ignoresSafeArea()
      .transition(.opacity.animation(.easeOut(duration: 0.2)))
      .onTapGesture {
        dismissModal()
      }
  }
  
  /// Builds the main content of the modal, including the drag indicator and user-provided content.
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
  
  /// Creates the drag indicator view at the top of the modal.
  @ViewBuilder
  private var dragIndicator: some View {
    RoundedRectangle(cornerRadius: 2.5)
      .fill(configuration.dragIndicatorColor)
      .frame(width: 36, height: 5)
      .padding(.top, 12)
      .padding(.bottom, 20)
  }
  
  /// A view that reads the size of its content and updates the `contentSize` state.
  @ViewBuilder
  private var sizeReader: some View {
    GeometryReader { proxy in
      Color.clear
        .preference(key: SizePreferenceKey.self, value: proxy.size)
    }
    .onPreferenceChange(SizePreferenceKey.self) { size in
      DispatchQueue.main.async {
        contentSize = size
      }
    }
  }
  
  // MARK: - Gestures and Animations
  
  /// The drag gesture used for interactive dismissal of the modal.
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
  
  /// Calculates the drag offset based on the gesture translation.
  ///
  /// - Parameter translation: The vertical translation of the drag gesture.
  /// - Returns: The calculated drag offset.
  private func calculateDragOffset(_ translation: CGFloat) -> CGFloat {
    if translation < 0 {
      return -sqrt(abs(translation)) * 4
    } else {
      return translation * 0.7
    }
  }
  
  /// Handles the end of a drag gesture, determining whether to dismiss the modal or reset its position.
  ///
  /// - Parameter value: The final value of the drag gesture.
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
  
  /// Dismisses the modal with a spring animation.
  private func dismissModal() {
    withAnimation(.spring(
      response: dismissConfig.response,
      dampingFraction: dismissConfig.dampingFraction
    )) {
      isPresented = false
    }
  }
  
  /// Defines the transition animation for the modal's appearance and disappearance.
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
