//
//  View+Modal.swift
//  MHModal
//
//  Created by Michael Harrigan on 3/8/25.
//

import SwiftUI

/// Extension on `View` to provide a modern, elegant modal presentation.
extension View {
  /// Presents a dynamically-sized modal over the current view.
  ///
  /// Creates a beautiful modal presentation that automatically resizes to fit its content.
  /// The modal can be configured with custom appearance and behavior.
  ///
  /// - Parameters:
  ///   - isPresented: Controls whether the modal is displayed
  ///   - appearance: Visual styling configuration (optional)
  ///   - behavior: Interaction behavior configuration (optional)
  ///   - content: Content view to display inside the modal
  ///
  /// - Returns: A view that presents a modal when `isPresented` is true
  ///
  /// - Example:
  ///   ```swift
  ///   Button("Show Modal") {
  ///     showModal = true
  ///   }
  ///   .modal(isPresented: $showModal) {
  ///     VStack {
  ///       Text("Hello World")
  ///       Button("Close") { showModal = false }
  ///     }
  ///     .padding()
  ///   }
  ///   ```
  public func modal<Content: View>(
    isPresented: Binding<Bool>,
    appearance: ModalAppearance = .default,
    behavior: ModalBehavior = .default,
    @ViewBuilder content: @escaping () -> Content
  ) -> some View {
    ZStack {
      self

      ModalView(
        isPresented: isPresented,
        appearance: appearance,
        behavior: behavior,
        content: content
      )
    }
    .ignoresSafeArea(edges: .bottom)
  }

  /// Legacy support for the original mhModal API
  @available(*, deprecated, message: "Use modal(isPresented:appearance:behavior:content:) instead")
  public func mhModal<Content: View>(
    isPresented: Binding<Bool>,
    @ViewBuilder content: @escaping () -> Content
  ) -> some View {
    // Use the new API with default settings
    return modal(
      isPresented: isPresented,
      appearance: .default,
      behavior: .default,
      content: content
    )
  }
}
