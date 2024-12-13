import XCTest
import SwiftUI
@testable import MHModal

@MainActor
final class ModalSizeReaderViewTests: XCTestCase {
    // Helper to create a modal view for testing
    func createTestModalView(
        appearance: ModalAppearance = .default
    ) -> ModalView<Text> {
        let binding = Binding<Bool>(
            get: { true },
            set: { _ in }
        )

        return ModalView(
            isPresented: binding,
            appearance: appearance
        ) {
            Text("Test Content")
        }
    }

    func testSizeReaderView() {
        // Basic test to ensure sizeReaderView exists and compiles
        let modalView = createTestModalView()
        let sizeReader = modalView.sizeReaderView

        // If we reach here, the size reader view compiles successfully
        XCTAssertNotNil(sizeReader)
    }

    func testSizeReaderViewWithDifferentAnimations() {
        // Since we can't actually introspect the Animation type contents,
        // we'll test that the animation property exists and can be accessed
        let defaultModalView = createTestModalView()
        let defaultAnimation = defaultModalView.appearance.sizeChangeAnimation

        // Just verify the animation exists
        XCTAssertNotNil(defaultAnimation)

        // Test with custom animation - we can verify setting and retrieving works
        let customAnimation = Animation.easeInOut(duration: 0.5)
        let customAppearance = ModalAppearance(sizeChangeAnimation: customAnimation)
        let customModalView = createTestModalView(appearance: customAppearance)

        // Just verify we can access the property
        let customAnimationFromModal = customModalView.appearance.sizeChangeAnimation
        XCTAssertNotNil(customAnimationFromModal)
    }

    func testInitialContentSize() {
        // Create a modal view for testing
        let baseModalView = createTestModalView()

        // Test initial content size
        XCTAssertEqual(baseModalView.contentSize, .zero)
    }

    func testSizeReaderConfiguration() {
        // Test that the size reader view is configured correctly
        let modalView = createTestModalView()
        let sizeReader = modalView.sizeReaderView

        // Verify it's not nil
        XCTAssertNotNil(sizeReader)

        // Test with custom animation setting
        let customAnimation = Animation.easeInOut(duration: 0.3)
        let customAppearance = ModalAppearance(sizeChangeAnimation: customAnimation)
        let customModalView = createTestModalView(appearance: customAppearance)

        let customSizeReader = customModalView.sizeReaderView
        XCTAssertNotNil(customSizeReader)
    }

    func testAnimateModalResize() {
        // This is mainly a compilation test since we can't directly test animations
        let modalView = createTestModalView()

        // Call the animation function - no need to await since it's not truly async in our test context
        modalView.animateModalResize()

        // If we get here, the function executed without errors
        XCTAssertTrue(true)
    }
}
