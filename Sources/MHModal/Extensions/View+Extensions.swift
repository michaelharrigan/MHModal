//
//  View+Extensions.swift
//  MHModal
//
//  Created by Michael Harrigan on 11/1/24.
//

import SwiftUI

/// Extension on `View` to provide a convenient way to present an `MHModal`.
extension View {
  /// Presents an `MHModal` over the current view.
  ///
  /// This method allows you to easily add a modal presentation to any view in your SwiftUI hierarchy.
  /// The modal will be presented when `isPresented` is true and dismissed when it becomes false.
  ///
  /// - Parameters:
  ///   - isPresented: A binding to a Boolean value that determines whether the modal is currently presented.
  ///   - configuration: The configuration options for the modal. Defaults to `MHModalConfiguration.default()`.
  ///   - content: A closure that returns the content view to be displayed within the modal.
  ///
  /// - Returns: A view that presents the modal when `isPresented` is true.
  ///
  /// - Example:
  ///   ```swift
  ///   struct ContentView: View {
  ///       @State private var showModal = false
  ///
  ///       var body: some View {
  ///           Button("Show Modal") {
  ///               showModal = true
  ///           }
  ///           .mhModal(isPresented: $showModal) {
  ///               Text("Modal Content")
  ///                   .padding()
  ///           }
  ///       }
  ///   }
  ///   ```
  public func mhModal<Content: View>(
    isPresented: Binding<Bool>,
    configuration: MHModalConfiguration = MHModalConfiguration.default(),
    @ViewBuilder content: @escaping () -> Content
  ) -> some View {
    ZStack {
      self
      if isPresented.wrappedValue {
        MHModal(
          isPresented: isPresented,
          configuration: configuration,
          content: content)
      }
    }
  }
}
