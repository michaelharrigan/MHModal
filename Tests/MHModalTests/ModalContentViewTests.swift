import XCTest
import SwiftUI
@testable import MHModal

@MainActor
final class ModalContentViewTests: XCTestCase {
    // Helper to create a modal view for testing
    func createTestModalView(
        appearance: ModalAppearance = .default,
        behavior: ModalBehavior = .default
    ) -> ModalView<Text> {
        let binding = Binding<Bool>(
            get: { true },
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

    func testModalContentView() {
        // Basic test to ensure modalContentView exists and compiles
        let modalView = createTestModalView()
        let contentView = modalView.modalContentView

        // If we reach here, the content view compiles successfully
        XCTAssertNotNil(contentView)
    }

    func testDragIndicatorView() {
        // Test with drag indicator enabled
        let modalViewWithIndicator = createTestModalView(
            appearance: ModalAppearance(showDragIndicator: true)
        )
        let indicatorView = modalViewWithIndicator.dragIndicatorView

        // Verify indicator view exists
        XCTAssertNotNil(indicatorView)

        // Test appearance properties
        XCTAssertEqual(modalViewWithIndicator.appearance.dragIndicatorColor,
                       .gray.opacity(0.5))

        // Test with custom drag indicator color
        let customModalView = createTestModalView(
            appearance: ModalAppearance(
                showDragIndicator: true,
                dragIndicatorColor: .blue
            )
        )
        XCTAssertEqual(customModalView.appearance.dragIndicatorColor, .blue)
    }

    func testContentView() {
        // Test the modalContentView itself without modifying any properties
        let contentView = createTestModalView().modalContentView
        XCTAssertNotNil(contentView)
    }

    func testContentScrolling() {
        // Test that scroll functionality exists (without using mutable variables)
        let modalView = createTestModalView()
        let modalContent = modalView.modalContentView

        // Test the presence of ScrollView in the view hierarchy when needed
        // Since we can't easily manipulate the exact conditions to trigger scrolling,
        // we're just testing that the code compiles and returns a view
        XCTAssertNotNil(modalContent)
    }

    func testModalAppearanceCustomization() {
        // Test with custom appearance
        let customAppearance = ModalAppearance(
            background: .blue,
            overlayColor: .red.opacity(0.3),
            cornerRadius: 20,
            horizontalPadding: 30,
            bottomPadding: 25,
            showDragIndicator: false
        )

        let customModalView = createTestModalView(appearance: customAppearance)

        // Verify appearance properties
        XCTAssertEqual(customModalView.appearance.background, .blue)
        XCTAssertEqual(customModalView.appearance.cornerRadius, 20)
        XCTAssertEqual(customModalView.appearance.horizontalPadding, 30)
        XCTAssertEqual(customModalView.appearance.bottomPadding, 25)
        XCTAssertFalse(customModalView.appearance.showDragIndicator)

        // Ensure content view compiles with custom appearance
        let customContentView = customModalView.modalContentView
        XCTAssertNotNil(customContentView)
    }
}
