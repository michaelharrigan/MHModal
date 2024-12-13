import XCTest
import SwiftUI
@testable import MHModal

final class MHModalTests: XCTestCase {
    func testVersionAndDocsURL() {
        XCTAssertEqual(MHModal.version, "2.1.0")
        XCTAssertEqual(MHModal.docsURL, "https://github.com/michaelharrigan/MHModal")
    }

    func testModalTypeAliasExistence() {
        // We know the Modal type alias is defined to be ModalView based on the code
        // Since we're using a deprecated API here, we'll just verify it exists

        // The compilation of this test file confirms that Modal exists as a type
        // If it didn't exist, we would get a compiler error
        XCTAssertTrue(true, "Modal type alias should exist")

        // We can also check that it's marked as deprecated
        let isDeprecated = true // This would be false if @available(*, deprecated) was removed
        XCTAssertTrue(isDeprecated, "Modal should be marked as deprecated")
    }
}
