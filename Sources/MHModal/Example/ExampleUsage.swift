//
//  ExampleUsage.swift
//  MHModal
//
//  Created by Michael Harrigan on 11/1/24.
//
import SwiftUI
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
#Preview {
  ContentView()
}
