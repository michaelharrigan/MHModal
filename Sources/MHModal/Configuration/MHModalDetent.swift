//
//  MHModalDetent.swift
//  MHModal
//
//  Created by Michael Harrigan on 11/1/24.
//

import SwiftUI

public enum MHModalDetent: Equatable {
  case medium
  case large
  case custom(height: CGFloat)

  var heightMultiplier: CGFloat {
    switch self {
    case .medium:
      return 0.5
    case .large:
      return 0.85
    case .custom(let height):
      return height
    }
  }
}
