import XCTest
import SwiftUI
@testable import MHModal

final class SizePreferenceKeyTests: XCTestCase {
    func testDefaultValue() {
        // Test that the default value is .zero
        let defaultValue = SizePreferenceKey.defaultValue
        XCTAssertEqual(defaultValue, .zero)
    }

    func testReduceFunction() {
        // Test that the reduce function properly updates the value
        var currentValue = CGSize.zero
        let nextValue = CGSize(width: 100, height: 200)

        SizePreferenceKey.reduce(value: &currentValue) { nextValue }

        XCTAssertEqual(currentValue, nextValue)
    }

    func testMultipleReductions() {
        // Test that multiple reductions work as expected
        var currentValue = CGSize.zero

        // First reduction
        SizePreferenceKey.reduce(value: &currentValue) { CGSize(width: 100, height: 100) }
        XCTAssertEqual(currentValue, CGSize(width: 100, height: 100))

        // Second reduction should replace the previous value
        SizePreferenceKey.reduce(value: &currentValue) { CGSize(width: 200, height: 300) }
        XCTAssertEqual(currentValue, CGSize(width: 200, height: 300))
    }

    @MainActor
    func testPreferenceKeyInView() {
        // This is mostly a compilation test to ensure the preference key works with SwiftUI

        let testView = GeometryReader { proxy in
            Color.clear
                .preference(key: SizePreferenceKey.self, value: proxy.size)
        }

        // If we reach here without compiler errors, the preference key works with SwiftUI
        XCTAssertNotNil(testView)
    }
}
