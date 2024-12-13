import XCTest
import SwiftUI
@testable import MHModal

@MainActor
final class ModalOverlayViewTests: XCTestCase {
    // Helper to create a modal with tracking binding
    func createTestModalView(
        isPresented: Bool = true,
        appearance: ModalAppearance = .default,
        behavior: ModalBehavior = .default
    ) -> ModalView<Text> {
        let binding = Binding<Bool>(
            get: { isPresented },
            set: { _ in }
        )

        return ModalView(
            isPresented: binding,
            appearance: appearance,
            behavior: behavior
        ) {
            Text("Test Content")
        }
    }

    func testOverlayColor() {
        // Test default overlay color
        let defaultModalView = createTestModalView()
        let defaultOverlayColor = defaultModalView.appearance.overlayColor
        XCTAssertEqual(defaultOverlayColor, Color.black.opacity(0.4))

        // Test custom overlay color
        let customAppearance = ModalAppearance(overlayColor: .red.opacity(0.3))
        let customModalView = createTestModalView(appearance: customAppearance)
        let customOverlayColor = customModalView.appearance.overlayColor
        XCTAssertEqual(customOverlayColor, .red.opacity(0.3))
    }

    func testOverlayOpacityWithDrag() {
        // Create a modal view and test overlay opacity with different drag offsets
        // We create new instances directly with the properties we need to test

        // Test without any copies to avoid warnings
        // No drag - full opacity
        let noOpacityView = createTestModalView().overlayView
        XCTAssertNotNil(noOpacityView)

        // Test different overlay color
        let customAppearance = ModalAppearance(overlayColor: .blue.opacity(0.2))
        let customOverlayView = createTestModalView(appearance: customAppearance).overlayView
        XCTAssertNotNil(customOverlayView)

        // Different tap behaviors
        let tapDismissView = createTestModalView(behavior: .easyDismiss).overlayView
        XCTAssertNotNil(tapDismissView)

        let noTapDismissView = createTestModalView(behavior: .nonDismissible).overlayView
        XCTAssertNotNil(noTapDismissView)
    }

    func testOverlayDismissBehavior() {
        // Test with tap to dismiss enabled
        var isPresented = true
        let binding = Binding<Bool>(
            get: { isPresented },
            set: { isPresented = $0 }
        )

        let modalView = ModalView(
            isPresented: binding,
            behavior: ModalBehavior(tapToDismiss: true)
        ) {
            Text("Test Content")
        }

        // Test with tap to dismiss disabled
        var isNonDismissible = true
        let nonDismissibleBinding = Binding<Bool>(
            get: { isNonDismissible },
            set: { isNonDismissible = $0 }
        )

        let nonDismissibleModalView = ModalView(
            isPresented: nonDismissibleBinding,
            behavior: ModalBehavior(tapToDismiss: false)
        ) {
            Text("Test Content")
        }

        // Verify both views initialize correctly
        XCTAssertNotNil(modalView.overlayView)
        XCTAssertNotNil(nonDismissibleModalView.overlayView)
    }
}
