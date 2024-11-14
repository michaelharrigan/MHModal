//
//  MHModalDetent.swift
//  MHModal
//
//  Created by Michael Harrigan on 11/1/24.
//

import SwiftUI

/// Represents the available height stops for an `MHModal`.
///
/// Each case corresponds to a different height multiplier relative to the screen height.
public enum MHModalDetent: Equatable {
  /// A medium detent, suitable for most modal content.
  case medium
  /// A large detent, used for content that requires more vertical space.
  case large
  /// A custom detent with a specific height multiplier.
  case custom(height: CGFloat)
  
  /// The height multiplier associated with each detent.
  var heightMultiplier: CGFloat {
    switch self {
    case .medium:
      return 0.5 // 50% of the screen height
    case .large:
      return 0.85 // 85% of the screen height
    case .custom(let height):
      return min(max(height, 0), 1) // Ensure the custom height is between 0 and 1
    }
  }
}
