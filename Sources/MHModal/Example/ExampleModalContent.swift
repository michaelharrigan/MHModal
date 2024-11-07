//
//  ExampleModalContent.swift
//  MHModal
//
//  Created by Michael Harrigan on 11/1/24.
//
import SwiftUI

struct ExampleModalContent: View {
  @Binding var isPresented: Bool
  @State private var isExpanded = false

  var body: some View {
    VStack(spacing: 24) {
      Text("Modal Content")
        .font(.headline)

      if isExpanded {
        Text("Additional Content that expands the modal size smoothly")
          .transition(.opacity)
          .multilineTextAlignment(.center)
      }

      Button(action: {
        withAnimation(
          .spring(
            response: 0.35,
            dampingFraction: 0.7
          )
        ) {
          isExpanded.toggle()
        }
      }) {
        Text(isExpanded ? "Show Less" : "Show More")
          .font(.headline)
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color.blue)
          .foregroundColor(.white)
          .cornerRadius(16)
      }

      Button(action: {
        withAnimation(
          .spring(
            response: 0.28,
            dampingFraction: 0.68
          )
        ) {
          isPresented = false
        }
      }) {
        Text("Close")
          .font(.headline)
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color.gray.opacity(0.15))
          .foregroundColor(.gray)
          .cornerRadius(16)
      }
    }
    .padding(.horizontal, 20)
    .padding(.bottom, 16)
  }
}
