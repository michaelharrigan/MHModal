//
//  ModalOverlayView.swift
//  MHModal
//
//  Created by Michael Harrigan on 3/8/25.
//

import SwiftUI

/// The overlay view that sits behind the modal.
extension ModalView {
  /// Background overlay behind the modal
  @ViewBuilder
  var overlayView: some View {
    appearance.overlayColor
      // Fade out overlay based on drag progress
      .opacity(0.4 * (1.0 - min(Double(dragOffset) / 300.0, 1.0)))
      .ignoresSafeArea()
      .transition(.opacity.animation(.easeOut(duration: 0.2)))
      .onTapGesture {
        if behavior.tapToDismiss {
          dismissModal()
        }
      }
  }
}
