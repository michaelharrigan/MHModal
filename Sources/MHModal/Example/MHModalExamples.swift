//
//  MHModalExamples.swift
//  MHModal
//
//  Created by Alex on 11/2/24.
//
//
import SwiftUI

/// A view that showcases different modal presentation styles and configurations using `MHModal`.
///
/// This struct provides a comprehensive example of how to use `MHModal` in various scenarios,
/// demonstrating different styles, configurations, and content types.
struct MHModalExamples: View {
  @State private var activeModal: ModalType?
  @Environment(\.colorScheme) private var colorScheme
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(ModalType.allCases, id: \.self) { type in
          Section {
            modalRow(for: type)
          } header: {
            Text(type.sectionTitle)
              .textCase(nil)
              .font(.headline)
              .foregroundStyle(.primary)
              .padding(.vertical, 8)
          }
        }
      }
      .navigationTitle("Modal Examples")
      .modifier(ModalPresenter(activeModal: $activeModal))
    }
  }

  /// Creates a row for each modal type in the list.
  ///
  /// - Parameter type: The `ModalType` for which to create a row.
  /// - Returns: A view representing a row in the list for a specific modal type.
  private func modalRow(for type: ModalType) -> some View {
    Button {
      activeModal = type
    } label: {
      HStack {
        type.icon
          .font(.title2)
          .foregroundStyle(type.tint)
          .frame(width: 32)
        
        VStack(alignment: .leading, spacing: 4) {
          Text(type.title)
            .font(.body)
            .foregroundStyle(.primary)
          
          Text(type.description)
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
      }
      .padding(.vertical, 8)
    }
  }
}
// MARK: - Modal Types
//
/// Represents different types of modals that can be presented.
private enum ModalType: String, CaseIterable {
  case basic, custom, dynamic, configured
  
  /// The icon associated with each modal type.
  var icon: Image {
    switch self {
    case .basic: Image(systemName: "rectangle.portrait")
    case .custom: Image(systemName: "sparkles.rectangle.stack")
    case .dynamic: Image(systemName: "rectangle.stack")
    case .configured: Image(systemName: "gearshape.rectangle")
    }
  }
  
  /// The tint color for each modal type.
  var tint: Color {
    switch self {
    case .basic: .blue
    case .custom: .purple
    case .dynamic: .orange
    case .configured: .green
    }
  }
  
  /// The title for each modal type.
  var title: String {
    switch self {
    case .basic: "Basic Modal"
    case .custom: "Custom Styled"
    case .dynamic: "Dynamic Content"
    case .configured: "Custom Configuration"
    }
  }
  
  /// A brief description of each modal type.
  var description: String {
    switch self {
    case .basic: "Simple modal presentation"
    case .custom: "Modal with custom visual styling"
    case .dynamic: "Adapts to content changes"
    case .configured: "Custom presentation behavior"
    }
  }
  
  /// The section title for each modal type.
  var sectionTitle: String { title }
  
  /// The configuration for each modal type.
  var configuration: MHModalConfiguration {
    switch self {
    case .configured:
      return MHModalConfiguration.Builder()
        .horizontalPadding(16)
        .bottomPadding(24)
        .cornerRadius(16)
        .backgroundColor(Color(uiColor: .systemBackground))
        .dragIndicatorColor(Color(uiColor: .secondaryLabel))
        .showDragIndicator(true)
        .build()
    default: return MHModalConfiguration.default()
    }
  }
}
// MARK: - Modal Presenter
//
/// A view modifier that presents the appropriate modal based on the active modal type.
private struct ModalPresenter: ViewModifier {
  @Binding var activeModal: ModalType?
  
  func body(content: Content) -> some View {
    content
      .mhModal(
        isPresented: .init(
          get: { activeModal != nil },
          set: { if !$0 { activeModal = nil } }
        ),
        configuration: activeModal?.configuration ?? MHModalConfiguration.default()
      ) {
        if let type = activeModal {
          modalContent(for: type)
        }
      }
  }
  
  /// Returns the appropriate modal content based on the modal type.
  ///
  /// - Parameter type: The `ModalType` for which to create content.
  /// - Returns: A view representing the content for the specified modal type.
  @ViewBuilder
  private func modalContent(for type: ModalType) -> some View {
    switch type {
    case .basic:
      BasicModalContent { activeModal = nil }
    case .custom:
      CustomModalContent { activeModal = nil }
    case .dynamic:
      DynamicModalContent { activeModal = nil }
    case .configured:
      ConfiguredModalContent { activeModal = nil }
    }
  }
}
// MARK: - Modal Contents
//
/// Represents the content for a basic modal.
private struct BasicModalContent: View {
  let onDismiss: () -> Void
  
  var body: some View {
    VStack(spacing: 24) {
      VStack(spacing: 8) {
        Text("Basic Modal")
          .font(.title2.bold())
        Text("A simple example of modal content with standard styling.")
          .font(.subheadline)
          .foregroundStyle(.secondary)
          .multilineTextAlignment(.center)
      }
      
      Button(action: onDismiss) {
        Text("Dismiss")
          .font(.headline)
          .frame(maxWidth: .infinity)
      }
      .buttonStyle(.borderedProminent)
      .controlSize(.large)
    }
    .padding(24)
  }
}

/// Represents the content for a custom styled modal.
private struct CustomModalContent: View {
  let onDismiss: () -> Void
  
  var body: some View {
    VStack(spacing: 24) {
      sparklesImage
      
      VStack(spacing: 8) {
        Text("Custom Styled")
          .font(.title2.bold())
        Text("This modal demonstrates custom visual styling with animations and effects.")
          .font(.subheadline)
          .foregroundStyle(.secondary)
          .multilineTextAlignment(.center)
      }
      
      Button(action: onDismiss) {
        Text("Done")
          .font(.headline)
          .frame(maxWidth: .infinity)
      }
      .buttonStyle(.borderedProminent)
      .tint(.purple)
      .controlSize(.large)
    }
    .padding(24)
    .background(.ultraThinMaterial)
  }
  
  /// Creates a sparkles image with appropriate effects based on the iOS version.
  @ViewBuilder
  private var sparklesImage: some View {
    if #available(iOS 18.0, *) {
      // iOS 18.0+ uses repeating bounce effect
      Image(systemName: "sparkles.rectangle.stack.fill")
        .font(.system(size: 48))
        .foregroundStyle(.purple)
        .symbolEffect(.bounce, options: .repeating)
    } else if #available(iOS 17.0, *) {
      // iOS 17.0+ uses standard bounce effect
      Image(systemName: "sparkles.rectangle.stack.fill")
        .font(.system(size: 48))
        .foregroundStyle(.purple)
      //        .symbolEffect(.bounce)
    } else {
      // iOS < 17.0 uses standard image
      Image(systemName: "sparkles.rectangle.stack.fill")
        .font(.system(size: 48))
        .foregroundColor(.purple)
    }
  }
}

/// Represents the content for a modal with dynamic content.
private struct DynamicModalContent: View {
  let onDismiss: () -> Void
  @State private var isExpanded = false
  
  var body: some View {
    VStack(spacing: 24) {
      VStack(spacing: 8) {
        Text("Dynamic Content")
          .font(.title2.bold())
        Text("Watch how the modal smoothly adapts as content changes.")
          .font(.subheadline)
          .foregroundStyle(.secondary)
          .multilineTextAlignment(.center)
      }
      
      if isExpanded {
        VStack(spacing: 16) {
          expandedImage
          
          Text("Additional content appears with smooth animations, demonstrating the modal's ability to adapt to content changes.")
            .font(.callout)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
        }
        .transition(.move(edge: .top).combined(with: .opacity))
      }
      
      VStack(spacing: 12) {
        Button {
          withAnimation(.spring()) {
            isExpanded.toggle()
          }
        } label: {
          Text(isExpanded ? "Show Less" : "Show More")
            .font(.headline)
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.bordered)
        .controlSize(.large)
        
        Button(action: onDismiss) {
          Text("Dismiss")
            .font(.headline)
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .tint(.orange)
        .controlSize(.large)
      }
    }
    .padding(24)
  }
  
  @ViewBuilder
  private var expandedImage: some View {
    if #available(iOS 17.0, *) {
      Image(systemName: "rectangle.stack.fill")
        .font(.system(size: 48))
        .foregroundStyle(.orange)
      //        .symbolEffect(.bounce)
    } else {
      Image(systemName: "rectangle.stack.fill")
        .font(.system(size: 48))
        .foregroundColor(.orange)
    }
  }
}

/// Represents the content for a modal with custom configuration.
private struct ConfiguredModalContent: View {
  let onDismiss: () -> Void
  
  var body: some View {
    VStack(spacing: 24) {
      gearImage
      
      VStack(spacing: 8) {
        Text("Custom Configuration")
          .font(.title2.bold())
        Text("This modal uses custom presentation configuration with different padding, corner radius, and indicator style.")
          .font(.subheadline)
          .foregroundStyle(.secondary)
          .multilineTextAlignment(.center)
      }
      
      Button(action: onDismiss) {
        Text("Close")
          .font(.headline)
          .frame(maxWidth: .infinity)
      }
      .buttonStyle(.borderedProminent)
      .tint(.green)
      .controlSize(.large)
    }
    .padding(24)
  }
  
  @ViewBuilder
  private var gearImage: some View {
    if #available(iOS 17.0, *) {
      Image(systemName: "gearshape.rectangle.fill")
        .font(.system(size: 48))
        .foregroundStyle(.green)
        .symbolEffect(.pulse)
    } else {
      Image(systemName: "gearshape.rectangle.fill")
        .font(.system(size: 48))
        .foregroundColor(.green)
    }
  }
}

#Preview {
  MHModalExamples()
}
