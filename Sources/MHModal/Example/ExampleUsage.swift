//
//  ExampleUsage.swift
//  MHModal
//
//  Created by Michael Harrigan on 11/1/24.
//
import SwiftUI

/// A view that demonstrates the basic usage of `MHModal`.
///
/// This example shows how to present a modal using the `mhModal` modifier
/// and how to control its presentation state.
struct ContentView: View {
  @State private var showModal = false

  var body: some View {
    ZStack {
      Color.gray.opacity(0.1).ignoresSafeArea()

      Button("Show Modal") {
        withAnimation(.spring()) {
          showModal = true
        }
      }
    }
    .mhModal(isPresented: $showModal) {
      ExampleModalContent(isPresented: $showModal)
    }
  }
}

/// Provides a preview of the `ContentView`.
#Preview {
  ContentView()
}
