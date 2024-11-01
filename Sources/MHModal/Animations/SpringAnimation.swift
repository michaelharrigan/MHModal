//
//  SpringAnimation.swift
//  MHModal
//
//  Created by Michael Harrigan on 11/1/24.
//

import SwiftUI

/// A structure that encapsulates the parameters for a spring animation.
///
/// This struct is used to define the characteristics of a spring animation,
/// which can be applied to various UI elements for smooth, natural-looking transitions.
public struct SpringAnimation {
  // MARK: - Properties

  /// The response time of the spring animation.
  ///
  /// This value determines how quickly the animation responds to changes.
  /// A lower value results in a faster response.
  public let response: Double

  /// The damping fraction of the spring animation.
  ///
  /// This value determines how quickly the animation settles.
  /// A value of 1 results in no oscillation, while lower values allow for more oscillation.
  public let dampingFraction: Double

  // MARK: - Initialization

  /// Creates a new `SpringAnimation` instance with the specified parameters.
  ///
  /// - Parameters:
  ///   - response: The response time of the spring animation. Default is 0.35.
  ///   - dampingFraction: The damping fraction of the spring animation. Default is 0.7.
  public init(response: Double = 0.35, dampingFraction: Double = 0.7) {
    self.response = response
    self.dampingFraction = dampingFraction
  }
}
