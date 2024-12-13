//
//  SimpleExample.swift
//  MHModal
//
//  Created by Michael Harrigan on 3/8/25.
//

import SwiftUI

/// A simple example showing the basic usage of MHModal
public struct SimpleExample: View {
    @State private var showModal = false

    public init() { }

    public var body: some View {
        VStack(spacing: 20) {
            Text("MHModal Simple Example")
                .font(.headline)

            Button("Show Modal") {
                showModal = true
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .modal(isPresented: $showModal) {
            VStack(spacing: 20) {
                Text("Hello World!")
                    .font(.title)

                Text("This is a simple example of MHModal.")
                    .multilineTextAlignment(.center)

                Button("Close") {
                    showModal = false
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
            }
            .padding()
        }
    }
}

#Preview {
    SimpleExample()
}
