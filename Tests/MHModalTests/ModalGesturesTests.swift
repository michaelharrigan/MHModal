import XCTest
import SwiftUI
@testable import MHModal

@MainActor
final class ModalGesturesTests: XCTestCase {
    // Helper function to create a modal with tracking binding
    func createTestModalView(binding: Binding<Bool>, behavior: ModalBehavior = .default) -> ModalView<Text> {
        return ModalView(
            isPresented: binding,
            behavior: behavior
        ) {
            Text("Test Content")
        }
    }

    func testDragCalculation() {
        var isPresented = true
        let binding = Binding<Bool>(
            get: { isPresented },
            set: { isPresented = $0 }
        )

        let modalView = createTestModalView(binding: binding)

        // Test downward drag (positive translation)
        let downwardOffset = modalView.calculateDragOffset(100)
        XCTAssertEqual(downwardOffset, 70) // 100 * 0.7

        // Test upward drag (negative translation)
        let upwardOffset = modalView.calculateDragOffset(-100)
        XCTAssertEqual(upwardOffset, -40) // -sqrt(100) * 4

        // Test extreme drag values
        let extremeDownwardOffset = modalView.calculateDragOffset(1000)
        XCTAssertEqual(extremeDownwardOffset, 700) // 1000 * 0.7

        let extremeUpwardOffset = modalView.calculateDragOffset(-1000)
        XCTAssertEqual(extremeUpwardOffset, -126.49, accuracy: 0.1) // -sqrt(1000) * 4
    }

    // We'll simulate the impact of drag gesture using direct calculation instead of mock objects
    func testDragDismissalThresholds() {
        var isPresented = true
        let binding = Binding<Bool>(
            get: { isPresented },
            set: { isPresented = $0 }
        )

        // Test with default behavior
        let modalView = createTestModalView(binding: binding)

        // Test default threshold values
        XCTAssertEqual(modalView.behavior.dismissDistanceThreshold, 100)
        XCTAssertEqual(modalView.behavior.dismissVelocityThreshold, 170)

        // Test with custom behavior
        let customBehavior = ModalBehavior(
            enableDragToDismiss: true,
            dismissVelocityThreshold: 200,
            dismissDistanceThreshold: 150
        )

        let customModalView = createTestModalView(binding: binding, behavior: customBehavior)
        XCTAssertEqual(customModalView.behavior.dismissDistanceThreshold, 150)
        XCTAssertEqual(customModalView.behavior.dismissVelocityThreshold, 200)
    }

    func testDismissFunction() {
        var isPresented = true
        let binding = Binding<Bool>(
            get: { isPresented },
            set: { isPresented = $0 }
        )

        let modalView = createTestModalView(binding: binding)

        // Test the dismiss function directly
        modalView.dismissModal()

        // Verify the modal is dismissed
        XCTAssertFalse(isPresented, "Modal should be dismissed after calling dismissModal()")
    }

    func testModalTransition() {
        let binding = Binding<Bool>(get: { true }, set: { _ in })
        let modalView = createTestModalView(binding: binding)

        // Get the transition
        let transition = modalView.modalTransition

        // Verify transition exists
        XCTAssertNotNil(transition)
    }
}
