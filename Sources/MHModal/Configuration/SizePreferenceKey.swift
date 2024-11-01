//
//  SizePreferenceKey.swift
//  MHModal
//
//  Created by Michael Harrigan on 11/1/24.
//

import SwiftUI

struct SizePreferenceKey: @preconcurrency PreferenceKey {
  @MainActor static var defaultValue: CGSize = .zero

  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
    value = nextValue()
  }
}
