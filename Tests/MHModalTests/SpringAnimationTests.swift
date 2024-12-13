import XCTest
import SwiftUI
@testable import MHModal

final class SpringAnimationTests: XCTestCase {
    func testSpringAnimationDefaultValues() {
        let defaultSpring = SpringAnimation()

        XCTAssertEqual(defaultSpring.response, 0.35)
        XCTAssertEqual(defaultSpring.dampingFraction, 0.7)
    }

    func testSpringAnimationCustomValues() {
        let customSpring = SpringAnimation(response: 0.5, dampingFraction: 0.8)

        XCTAssertEqual(customSpring.response, 0.5)
        XCTAssertEqual(customSpring.dampingFraction, 0.8)
    }

    func testSpringAnimationEdgeCases() {
        // Test with extreme values
        let extremeResponse = SpringAnimation(response: 10.0, dampingFraction: 0.1)
        XCTAssertEqual(extremeResponse.response, 10.0)
        XCTAssertEqual(extremeResponse.dampingFraction, 0.1)

        // Test with zero values
        let zeroValues = SpringAnimation(response: 0.0, dampingFraction: 0.0)
        XCTAssertEqual(zeroValues.response, 0.0)
        XCTAssertEqual(zeroValues.dampingFraction, 0.0)
    }

    func testSpringAnimationToSwiftUIAnimation() {
        // This is more of a compilation test to ensure that SpringAnimation can be used 
        // in contexts where SwiftUI.Animation is expected
        let spring = SpringAnimation(response: 0.4, dampingFraction: 0.6)

        // Create a SwiftUI.Animation using the spring parameters
        let animation = Animation.spring(response: spring.response, dampingFraction: spring.dampingFraction)

        // Just a simple assertion to avoid compiler warnings about unused variables
        XCTAssertNotNil(animation)
    }
}
