import XCTest

@testable import MHModal

final class MHModalTests: XCTestCase {
  func testModalDetentHeightMultipliers() {
    // Test medium detent
    XCTAssertEqual(MHModalDetent.medium.heightMultiplier, 0.5)

    // Test large detent
    XCTAssertEqual(MHModalDetent.large.heightMultiplier, 0.85)

    // Test custom detent
    let customHeight: CGFloat = 0.75
    XCTAssertEqual(MHModalDetent.custom(height: customHeight).heightMultiplier, customHeight)
  }

  func testModalConfiguration() {
    // Test default configuration
    let defaultConfig = MHModalConfiguration()
    XCTAssertEqual(defaultConfig.horizontalPadding, 20)
    XCTAssertEqual(defaultConfig.cornerRadius, 38)
    XCTAssertTrue(defaultConfig.showDragIndicator)
    XCTAssertTrue(defaultConfig.enableDragToDismiss)
    XCTAssertEqual(defaultConfig.availableDetents, [.large])

    // Test custom configuration
    let customConfig = MHModalConfiguration(
      horizontalPadding: 16,
      cornerRadius: 24,
      showDragIndicator: false,
      availableDetents: [.medium, .large],
      enableDragToDismiss: false
    )
    XCTAssertEqual(customConfig.horizontalPadding, 16)
    XCTAssertEqual(customConfig.cornerRadius, 24)
    XCTAssertFalse(customConfig.showDragIndicator)
    XCTAssertFalse(customConfig.enableDragToDismiss)
    XCTAssertEqual(customConfig.availableDetents, [.medium, .large])
  }

  func testEmptyDetentsDefaultsToLarge() {
    let config = MHModalConfiguration(availableDetents: [])
    XCTAssertEqual(config.availableDetents, [.large])
  }
}
