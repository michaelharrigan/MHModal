//
//  SizePreferenceKey.swift
//  MHModal
//
//  Created by Michael Harrigan on 11/1/24.
//

import SwiftUI

/// A preference key for capturing and propagating size information in SwiftUI views.
///
/// This preference key is used to capture the size of a view and make it available to parent views.
/// It's particularly useful in scenarios where you need to adjust layouts based on the size of child views.
@preconcurrency struct SizePreferenceKey: PreferenceKey {
  /// The default value for the size preference.
  ///
  /// This is set to `.zero` as a starting point before any actual sizes are captured.
  static let defaultValue: CGSize = .zero
  
  /// Combines the current value with the next value in the preference key chain.
  ///
  /// In this implementation, it simply replaces the current value with the next value.
  /// This is suitable for scenarios where we're interested in the final size, not an accumulation of sizes.
  ///
  /// - Parameters:
  ///   - value: The current value, which will be updated.
  ///   - nextValue: A closure that returns the next value to be combined.
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
    value = nextValue()
  }
}
