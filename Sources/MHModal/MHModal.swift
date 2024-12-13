//
//  MHModal.swift
//  MHModal
//
//  Created by Michael Harrigan on 11/1/24.
//

/// MHModal provides a beautiful, dynamically-sized modal view for SwiftUI.
///
/// This is the main entry point for the MHModal package. To use the modal,
/// import this package and use the `.modal()` modifier on any SwiftUI view.
///
/// Example usage:
/// ```swift
/// import SwiftUI
/// import MHModal
///
/// struct ContentView: View {
///     @State private var showModal = false
///
///     var body: some View {
///         Button("Show Modal") {
///             showModal = true
///         }
///         .modal(isPresented: $showModal) {
///             Text("Hello World!")
///                 .padding()
///         }
///     }
/// }
/// ```
///
/// For customization options, see `ModalAppearance` and `ModalBehavior`.
public enum MHModal {

    /// Current library version
    public static let version = "2.1.0"

    /// Package documentation URL
    public static let docsURL = "https://github.com/michaelharrigan/MHModal"
}

// MARK: - Public Type Aliases

// These type aliases ensure backwards compatibility while allowing
// for more structured internal code organization

/// A view-based modal that automatically sizes to fit its content.
///
/// This type alias ensures backward compatibility with previous versions of MHModal.
/// For most uses, you should use the `.modal()` View extension instead of this type directly.
///
/// - SeeAlso: `View.modal(isPresented:appearance:behavior:content:)`
@available(*, deprecated, message: "Use the .modal() View extension instead")
public typealias Modal = ModalView
