//
//  MHModalConfiguration.swift
//  MHModal
//
//  Created by Michael Harrigan on 11/1/24.
//
import SwiftUI

public struct MHModalConfiguration {
  let horizontalPadding: CGFloat
  let bottomPadding: CGFloat
  let cornerRadius: CGFloat
  let backgroundColor: Color
  let dragIndicatorColor: Color
  let showDragIndicator: Bool
  let availableDetents: [MHModalDetent]
  let enableDragToDismiss: Bool

  public init(
    horizontalPadding: CGFloat = 20,
    bottomPadding: CGFloat = 20,
    cornerRadius: CGFloat = 38,
    backgroundColor: Color = .white,
    dragIndicatorColor: Color = .gray.opacity(0.5),
    showDragIndicator: Bool = true,
    availableDetents: [MHModalDetent] = [.large],
    enableDragToDismiss: Bool = true
  ) {
    self.horizontalPadding = horizontalPadding
    self.bottomPadding = bottomPadding
    self.cornerRadius = cornerRadius
    self.backgroundColor = backgroundColor
    self.dragIndicatorColor = dragIndicatorColor
    self.showDragIndicator = showDragIndicator
    self.availableDetents = availableDetents.isEmpty ? [.large] : availableDetents
    self.enableDragToDismiss = enableDragToDismiss
  }
}
