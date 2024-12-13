//
//  CustomAppearanceExamples.swift
//  MHModal
//
//  Created by Michael Harrigan on 3/8/25.
//

import SwiftUI

/// Examples demonstrating custom appearance configurations for the modal
public struct CustomAppearanceExamples: View {
  @State private var showLightModal = false
  @State private var showDarkModal = false
  @State private var showMinimalModal = false
  @State private var showCustomModal = false

  public init() { }

  public var body: some View {
    NavigationStack {
      List {
        Section(header: Text("Predefined Themes")) {
          Button("Light Theme") { showLightModal = true }
          Button("Dark Theme") { showDarkModal = true }
          Button("Minimal Theme") { showMinimalModal = true }
        }

        Section(header: Text("Custom Appearance")) {
          Button("Custom Appearance") { showCustomModal = true }
        }
      }
      .navigationTitle("Appearance Examples")
    }
    // Light theme modal
    .modal(
      isPresented: $showLightModal,
      appearance: .light
    ) {
      themeModalContent("Light Theme", "Standard light appearance with default configuration.")
    }

    // Dark theme modal
    .modal(
      isPresented: $showDarkModal,
      appearance: .dark
    ) {
      themeModalContent("Dark Theme", "Optimized for dark mode with adjusted colors and opacity.")
    }

    // Minimal theme modal
    .modal(
      isPresented: $showMinimalModal,
      appearance: .minimal
    ) {
      themeModalContent("Minimal Theme", "Clean appearance without the drag indicator.")
    }

    // Custom appearance modal
    .modal(
      isPresented: $showCustomModal,
      appearance: ModalAppearance(
        background: Color.blue.opacity(0.1),
        overlayColor: Color.purple.opacity(0.3),
        cornerRadius: 16,
        horizontalPadding: 30,
        bottomPadding: 30,
        showDragIndicator: true,
        dragIndicatorColor: .blue,
        maxHeightRatio: 0.7,
        sizeChangeAnimation: .bouncy,
        contentShrinkThreshold: 40,
        contentGrowthThreshold: 10
      )
    ) {
      themeModalContent("Custom Theme", "Fully customized appearance with unique styling.")
    }
  }

  private func themeModalContent(_ title: String, _ description: String) -> some View {
    VStack(spacing: 16) {
      Text(title)
        .font(.title)
        .bold()
        .padding(.top, 8)

      Text(description)
        .multilineTextAlignment(.center)
        .padding(.horizontal)

      Divider()
        .padding(.vertical, 8)

      Text("This modal demonstrates the appearance configuration options available in MHModal.")
        .font(.callout)
        .foregroundColor(.secondary)
        .multilineTextAlignment(.center)
        .padding(.horizontal)

      Spacer()

      Button("Close") {
        switch title {
        case "Light Theme":
          showLightModal = false
        case "Dark Theme":
          showDarkModal = false
        case "Minimal Theme":
          showMinimalModal = false
        case "Custom Theme":
          showCustomModal = false
        default:
          break
        }
      }
      .buttonStyle(.borderedProminent)
      .frame(maxWidth: .infinity)
      .padding(.horizontal)
      .padding(.bottom, 16)
    }
  }
}

/// Examples demonstrating custom behavior configurations for the modal
public struct CustomBehaviorExamples: View {
  @State private var showDefaultModal = false
  @State private var showNonDismissibleModal = false
  @State private var showEasyDismissModal = false
  @State private var showCustomBehaviorModal = false

  public init() { }

  public var body: some View {
    NavigationStack {
      List {
        Section(header: Text("Predefined Behaviors")) {
          Button("Default Behavior") { showDefaultModal = true }
          Button("Non-Dismissible") { showNonDismissibleModal = true }
          Button("Easy Dismiss") { showEasyDismissModal = true }
        }

        Section(header: Text("Custom Behavior")) {
          Button("Custom Behavior") { showCustomBehaviorModal = true }
        }
      }
      .navigationTitle("Behavior Examples")
    }
    // Default behavior modal
    .modal(
      isPresented: $showDefaultModal,
      behavior: .default
    ) {
      behaviorModalContent("Default Behavior", "Standard interactive behavior with drag and tap to dismiss.")
    }

    // Non-dismissible modal
    .modal(
      isPresented: $showNonDismissibleModal,
      behavior: .nonDismissible
    ) {
      VStack(spacing: 16) {
        Text("Non-Dismissible")
          .font(.title)
          .bold()
          .padding(.top, 8)

        Text("This modal can only be dismissed programmatically with the button below.")
          .multilineTextAlignment(.center)
          .padding(.horizontal)

        Text("Try dragging down or tapping outside - it won't dismiss!")
          .font(.callout)
          .foregroundColor(.secondary)
          .multilineTextAlignment(.center)
          .padding(.horizontal)

        Spacer()

        Button("Close") {
          showNonDismissibleModal = false
        }
        .buttonStyle(.borderedProminent)
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.bottom, 16)
      }
    }

    // Easy dismiss modal
    .modal(
      isPresented: $showEasyDismissModal,
      behavior: .easyDismiss
    ) {
      behaviorModalContent("Easy Dismiss", "Lower thresholds for easier dismissal - try a small drag or flick.")
    }

    // Custom behavior modal
    .modal(
      isPresented: $showCustomBehaviorModal,
      behavior: ModalBehavior(
        enableDragToDismiss: true,
        tapToDismiss: false,
        dismissVelocityThreshold: 250,
        dismissDistanceThreshold: 150
      )
    ) {
      behaviorModalContent("Custom Behavior", "Drag to dismiss enabled, but tap to dismiss disabled. Requires more drag distance or velocity.")
    }
  }

  private func behaviorModalContent(_ title: String, _ description: String) -> some View {
    VStack(spacing: 16) {
      Text(title)
        .font(.title)
        .bold()
        .padding(.top, 8)

      Text(description)
        .multilineTextAlignment(.center)
        .padding(.horizontal)

      Divider()
        .padding(.vertical, 8)

      Text("This modal demonstrates the behavior configuration options available in MHModal.")
        .font(.callout)
        .foregroundColor(.secondary)
        .multilineTextAlignment(.center)
        .padding(.horizontal)

      Spacer()

      Button("Close") {
        switch title {
        case "Default Behavior":
          showDefaultModal = false
        case "Easy Dismiss":
          showEasyDismissModal = false
        case "Custom Behavior":
          showCustomBehaviorModal = false
        default:
          break
        }
      }
      .buttonStyle(.borderedProminent)
      .frame(maxWidth: .infinity)
      .padding(.horizontal)
      .padding(.bottom, 16)
    }
  }
}

// MARK: - Previews
#Preview("Appearance Examples") {
  CustomAppearanceExamples()
}

#Preview("Behavior Examples") {
  CustomBehaviorExamples()
}
