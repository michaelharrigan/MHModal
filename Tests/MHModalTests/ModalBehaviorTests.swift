import XCTest
import SwiftUI
@testable import MHModal

final class ModalBehaviorTests: XCTestCase {
    func testDefaultBehavior() {
        let behavior = ModalBehavior.default

        XCTAssertTrue(behavior.enableDragToDismiss)
        XCTAssertTrue(behavior.tapToDismiss)
        XCTAssertEqual(behavior.dismissVelocityThreshold, 170)
        XCTAssertEqual(behavior.dismissDistanceThreshold, 100)
    }

    func testNonDismissibleBehavior() {
        let behavior = ModalBehavior.nonDismissible

        XCTAssertFalse(behavior.enableDragToDismiss)
        XCTAssertFalse(behavior.tapToDismiss)
        XCTAssertEqual(behavior.dismissVelocityThreshold, 170)
        XCTAssertEqual(behavior.dismissDistanceThreshold, 100)
    }

    func testEasyDismissBehavior() {
        let behavior = ModalBehavior.easyDismiss

        XCTAssertTrue(behavior.enableDragToDismiss)
        XCTAssertTrue(behavior.tapToDismiss)
        XCTAssertEqual(behavior.dismissVelocityThreshold, 100)
        XCTAssertEqual(behavior.dismissDistanceThreshold, 50)
    }

    func testCustomBehavior() {
        let customBehavior = ModalBehavior(
            enableDragToDismiss: false,
            tapToDismiss: false,
            dismissVelocityThreshold: 200,
            dismissDistanceThreshold: 150
        )

        XCTAssertFalse(customBehavior.enableDragToDismiss)
        XCTAssertFalse(customBehavior.tapToDismiss)
        XCTAssertEqual(customBehavior.dismissVelocityThreshold, 200)
        XCTAssertEqual(customBehavior.dismissDistanceThreshold, 150)
    }

    func testBehaviorEquality() {
        let behavior1 = ModalBehavior(
            enableDragToDismiss: false,
            dismissVelocityThreshold: 200
        )

        let behavior2 = ModalBehavior(
            enableDragToDismiss: false,
            dismissVelocityThreshold: 200
        )

        let behavior3 = ModalBehavior(
            enableDragToDismiss: true,
            dismissVelocityThreshold: 200
        )

        XCTAssertEqual(behavior1, behavior2)
        XCTAssertNotEqual(behavior1, behavior3)
    }
}
