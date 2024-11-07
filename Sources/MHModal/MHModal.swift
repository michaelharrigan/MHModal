//
//  MHModal.swift
//  MHModal
//
//  Created by Michael Harrigan on 11/1/24.
//

import SwiftUI

public struct MHModal<Content: View>: View {
  @Binding private var isPresented: Bool
  private let content: Content
  private let configuration: MHModalConfiguration
  @State private var contentSize: CGSize = .zero
  @State private var previousContentSize: CGSize = .zero
  @State private var dragOffset: CGFloat = 0
  @GestureState private var isDragging = false
  
  public init(isPresented: Binding<Bool>,
              configuration: MHModalConfiguration = MHModalConfiguration(),
              @ViewBuilder content: () -> Content) {
    self._isPresented = isPresented
    self.configuration = configuration
    self.content = content()
  }

  // Spring animation configurations
  private let springConfig = SpringAnimation(
    response: 0.35,  // Faster response
    dampingFraction: 0.7  // Less damping for more natural bounce
  )

  private let dismissConfig = SpringAnimation(
    response: 0.28,  // Quick dismissal
    dampingFraction: 0.68  // Slight bounce on dismiss
  )

  private var dragAnimation: Animation {
    isDragging ? .interactiveSpring() : .spring(
      response: springConfig.response,
      dampingFraction: springConfig.dampingFraction
    )
  }

  private func calculateDragOffset(_ translation: CGFloat) -> CGFloat {
    if translation < 0 {
      // Pulling up - logarithmic resistance
      return -sqrt(abs(translation)) * 4
    } else {
      // Pulling down - more natural follow
      return translation * 0.7
    }
  }

  public var body: some View {
    GeometryReader { _ in
      ZStack(alignment: .bottom) {
        if isPresented {
          // Background overlay
          Color.clear
            .opacity(0.4 * (1.0 - min(Double(dragOffset) / 300.0, 1.0)))
            .ignoresSafeArea()
            .transition(.opacity.animation(.easeOut(duration: 0.2)))
            .onTapGesture {
              withAnimation(.spring(
                response: dismissConfig.response,
                dampingFraction: dismissConfig.dampingFraction
              )) {
                isPresented = false
              }
            }

          // Modal content
          VStack(spacing: 0) {
            // Drag indicator
            if configuration.showDragIndicator {
              RoundedRectangle(cornerRadius: 2.5)
                .fill(configuration.dragIndicatorColor)
                .frame(width: 36, height: 5)
                .padding(.top, 12)
                .padding(.bottom, 20)
            }

            content
              .background(
                GeometryReader { proxy in
                  Color.clear
                    .preference(key: SizePreferenceKey.self, value: proxy.size)
                }
              )
              .onPreferenceChange(SizePreferenceKey.self) { newSize in
                previousContentSize = contentSize
                contentSize = newSize
              }
          }
          .frame(maxWidth: .infinity)
          .background(Color.white)
          .clipShape(RoundedRectangle(cornerRadius: configuration.cornerRadius, style: .continuous))
          .shadow(
            color: Color.black.opacity(0.15),
            radius: 10,
            x: 0,
            y: -2
          )
          .padding(.horizontal, configuration.horizontalPadding)
          .padding(.bottom, configuration.bottomPadding)
          .offset(y: dragOffset)
          .scaleEffect(
            1.0 - min(abs(dragOffset) / 1000, 0.1),
            anchor: dragOffset > 0 ? .bottom : .top
          )
          .animation(dragAnimation, value: dragOffset)
          .gesture(
            DragGesture()
              .updating($isDragging) { _, state, _ in
                state = true
              }
              .onChanged { value in
                dragOffset = calculateDragOffset(value.translation.height)
              }
              .onEnded { value in
                let velocity = value.predictedEndLocation.y - value.location.y
                let shouldDismiss = value.translation.height > 100 || velocity > 170

                if shouldDismiss {
                  withAnimation(.spring(
                    response: dismissConfig.response,
                    dampingFraction: dismissConfig.dampingFraction
                  )) {
                    isPresented = false
                  }
                } else {
                  withAnimation(.spring(
                    response: springConfig.response,
                    dampingFraction: springConfig.dampingFraction
                  )) {
                    dragOffset = 0
                  }
                }
              }
          )
          .transition(
            .asymmetric(
              insertion: AnyTransition.opacity
                .combined(with: .move(edge: .bottom))
                .combined(with: .scale(scale: 0.93, anchor: .bottom))
                .animation(.spring(
                  response: 0.45,
                  dampingFraction: 0.8
                )),
              removal: AnyTransition.opacity
                .combined(with: .move(edge: .bottom))
                .animation(.spring(
                  response: dismissConfig.response,
                  dampingFraction: dismissConfig.dampingFraction
                ))
            )
          )
        }
      }
    }
  }
}
