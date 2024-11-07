//
//  View+Extensions.swift
//  MHModal
//
//  Created by Michael Harrigan on 11/1/24.
//

import SwiftUI

public extension View {
  func mhModal<Content: View>(
    isPresented: Binding<Bool>,
    configuration: MHModalConfiguration = MHModalConfiguration(),
    @ViewBuilder content: @escaping () -> Content
  ) -> some View {
    ZStack {
      self
      if isPresented.wrappedValue {
        MHModal(isPresented: isPresented,
                configuration: configuration,
                content: content)
      }
    }
  }
}
