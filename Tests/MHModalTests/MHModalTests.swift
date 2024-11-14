import XCTest
import SwiftUI
@testable import MHModal

final class MHModalTests: XCTestCase {
  // MARK: - MHModalDetent Tests
  
  func testModalDetentHeightMultipliers() {
    // Test medium detent
    XCTAssertEqual(MHModalDetent.medium.heightMultiplier, 0.5)
    
    // Test large detent
    XCTAssertEqual(MHModalDetent.large.heightMultiplier, 0.85)
    
    // Test custom detent
    let customHeight: CGFloat = 0.75
    XCTAssertEqual(MHModalDetent.custom(height: customHeight).heightMultiplier, customHeight)
    
    // Test custom detent with value greater than 1
    XCTAssertEqual(MHModalDetent.custom(height: 1.5).heightMultiplier, 1.0)
    
    // Test custom detent with negative value
    XCTAssertEqual(MHModalDetent.custom(height: -0.5).heightMultiplier, 0.0)
  }
  
  // MARK: - MHModalConfiguration Tests
  
  func testDefaultModalConfiguration() {
    let defaultConfig = MHModalConfiguration.default()
    
    XCTAssertEqual(defaultConfig.horizontalPadding, 20)
    XCTAssertEqual(defaultConfig.bottomPadding, 20)
    XCTAssertEqual(defaultConfig.cornerRadius, 38)
    XCTAssertEqual(defaultConfig.backgroundColor, .white)
    XCTAssertEqual(defaultConfig.dragIndicatorColor, Color.gray.opacity(0.5))
    XCTAssertTrue(defaultConfig.showDragIndicator)
    XCTAssertEqual(defaultConfig.availableDetents, [.large])
    XCTAssertTrue(defaultConfig.enableDragToDismiss)
  }
  
  func testCustomModalConfiguration() {
    let customConfig = MHModalConfiguration.Builder()
      .horizontalPadding(16)
      .bottomPadding(24)
      .cornerRadius(24)
      .backgroundColor(.blue)
      .dragIndicatorColor(.red)
      .showDragIndicator(false)
      .availableDetents([.medium, .large])
      .enableDragToDismiss(false)
      .build()
    
    XCTAssertEqual(customConfig.horizontalPadding, 16)
    XCTAssertEqual(customConfig.bottomPadding, 24)
    XCTAssertEqual(customConfig.cornerRadius, 24)
    XCTAssertEqual(customConfig.backgroundColor, .blue)
    XCTAssertEqual(customConfig.dragIndicatorColor, .red)
    XCTAssertFalse(customConfig.showDragIndicator)
    XCTAssertEqual(customConfig.availableDetents, [.medium, .large])
    XCTAssertFalse(customConfig.enableDragToDismiss)
  }
  
  func testEmptyDetentsDefaultsToLarge() {
    let config = MHModalConfiguration.Builder()
      .availableDetents([])
      .build()
    
    XCTAssertEqual(config.availableDetents, [.large])
  }
  
  // MARK: - SpringAnimation Tests
  
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
}
