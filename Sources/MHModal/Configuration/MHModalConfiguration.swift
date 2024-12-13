//
//  MHModalConfiguration.swift
//  MHModal
//
//  Created by Michael Harrigan on 11/1/24.
//
import SwiftUI

/// Configuration options for customizing the appearance and behavior of an `MHModal`.
///
/// Use this struct to fine-tune various aspects of the modal, such as its background color,
/// corner radius, drag behavior, and available detents.
public struct MHModalConfiguration {
  // MARK: - Properties

  /// The horizontal padding applied to the modal content.
  let horizontalPadding: CGFloat

  /// The bottom padding applied to the modal content.
  let bottomPadding: CGFloat

  /// The corner radius of the modal.
  let cornerRadius: CGFloat

  /// The background color of the modal.
  let backgroundColor: Color

  /// The color of the drag indicator.
  let dragIndicatorColor: Color

  /// Determines whether to show the drag indicator at the top of the modal.
  let showDragIndicator: Bool

  /// The available detents (height stops) for the modal.
  let availableDetents: [MHModalDetent]

  /// Determines whether the modal can be dismissed by dragging.
  let enableDragToDismiss: Bool

  /// The dimmed overlay behind the modal content.
  let contentOverlayColor: Color

  // MARK: - Initialization

  /// Private initializer that creates a new `MHModalConfiguration` instance from a `Builder`.
  ///
  /// - Parameter builder: The `Builder` instance containing the configuration values.
  private init(builder: Builder) {
    self.horizontalPadding = builder.horizontalPadding
    self.bottomPadding = builder.bottomPadding
    self.cornerRadius = builder.cornerRadius
    self.backgroundColor = builder.backgroundColor
    self.dragIndicatorColor = builder.dragIndicatorColor
    self.showDragIndicator = builder.showDragIndicator
    self.availableDetents = builder.availableDetents.isEmpty ? [.large] : builder.availableDetents
    self.enableDragToDismiss = builder.enableDragToDismiss
    self.contentOverlayColor = builder.contentOverlayColor
  }

  // MARK: - Builder

  /// A builder class for creating `MHModalConfiguration` instances.
  ///
  /// Use this class to construct a configuration step by step, setting only the properties you need.
  public class Builder {
    // MARK: Properties
    var horizontalPadding: CGFloat = 20
    var bottomPadding: CGFloat = 20
    var cornerRadius: CGFloat = 38
    var backgroundColor: Color = .white
    var dragIndicatorColor: Color = .gray.opacity(0.5)
    var showDragIndicator: Bool = true
    var availableDetents: [MHModalDetent] = [.large]
    var enableDragToDismiss: Bool = true
    var contentOverlayColor: Color = .black

    /// Initializes a new `Builder` instance with default values.
    public init() {}

    // MARK: Builder Methods

    /// Sets the dimmed overlay color behind the modal.
    @discardableResult
    public func contentOverlayColor(_ value: Color) -> Builder {
      self.contentOverlayColor = value
      return self
    }

    /// Sets the horizontal padding for the modal.
    @discardableResult
    public func horizontalPadding(_ value: CGFloat) -> Builder {
      self.horizontalPadding = value
      return self
    }

    /// Sets the bottom padding for the modal.
    @discardableResult
    public func bottomPadding(_ value: CGFloat) -> Builder {
      self.bottomPadding = value
      return self
    }

    /// Sets the corner radius for the modal.
    @discardableResult
    public func cornerRadius(_ value: CGFloat) -> Builder {
      self.cornerRadius = value
      return self
    }

    /// Sets the background color for the modal.
    @discardableResult
    public func backgroundColor(_ value: Color) -> Builder {
      self.backgroundColor = value
      return self
    }

    /// Sets the color of the drag indicator.
    @discardableResult
    public func dragIndicatorColor(_ value: Color) -> Builder {
      self.dragIndicatorColor = value
      return self
    }

    /// Sets whether to show the drag indicator.
    @discardableResult
    public func showDragIndicator(_ value: Bool) -> Builder {
      self.showDragIndicator = value
      return self
    }

    /// Sets the available detents for the modal.
    @discardableResult
    public func availableDetents(_ value: [MHModalDetent]) -> Builder {
      self.availableDetents = value
      return self
    }

    /// Sets whether the modal can be dismissed by dragging.
    @discardableResult
    public func enableDragToDismiss(_ value: Bool) -> Builder {
      self.enableDragToDismiss = value
      return self
    }

    /// Builds and returns an `MHModalConfiguration` instance.
    public func build() -> MHModalConfiguration {
      return MHModalConfiguration(builder: self)
    }
  }

  // MARK: - Static Methods

  /// Returns a default configuration for `MHModal`.
  ///
  /// This configuration uses the default values for all properties.
  ///
  /// - Returns: A default `MHModalConfiguration` instance.
  public static func `default`() -> MHModalConfiguration {
    return Builder().build()
  }
}
