import XCTest
import SwiftUI
@testable import MHModal

@MainActor
final class ModalViewCoreTests: XCTestCase {
    // Helper to create a modal view for testing
    func createTestModalView(isPresented: Bool = true,
                             appearance: ModalAppearance = .default,
                             behavior: ModalBehavior = .default) -> ModalView<Text> {
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

    func testModalViewProperties() {
        let modalView = createTestModalView()

        // Test spring animations
        XCTAssertEqual(modalView.dragSpring.response, 0.35)
        XCTAssertEqual(modalView.dragSpring.dampingFraction, 0.7)

        XCTAssertEqual(modalView.standardSpring.response, 0.45)
        XCTAssertEqual(modalView.standardSpring.dampingFraction, 0.8)
    }

    func testTopPadding() {
        // Test with drag indicator
        let withIndicatorView = createTestModalView(appearance: ModalAppearance(showDragIndicator: true))
        XCTAssertEqual(withIndicatorView.topPadding, 36)

        // Test without drag indicator
        let withoutIndicatorView = createTestModalView(appearance: ModalAppearance(showDragIndicator: false))
        XCTAssertEqual(withoutIndicatorView.topPadding, 0)
    }

    func testModalThresholds() {
        // Test default thresholds
        let defaultModalView = createTestModalView()
        XCTAssertEqual(defaultModalView.shrinkThreshold, 80)
        XCTAssertEqual(defaultModalView.growthThreshold, 20)

        // Test custom thresholds
        let customAppearance = ModalAppearance(contentShrinkThreshold: 100, contentGrowthThreshold: 50)
        let customModalView = createTestModalView(appearance: customAppearance)
        XCTAssertEqual(customModalView.shrinkThreshold, 100)
        XCTAssertEqual(customModalView.growthThreshold, 50)
    }
}
