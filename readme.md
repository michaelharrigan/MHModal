# MHModal

A dynamic, content-adaptive floating modal for SwiftUI.

![MHModal Example](https://raw.githubusercontent.com/michaelharrigan/MHModal/main/preview.gif)

## Features

- **Auto-resizing**: Adapts to content changes
- **Customizable**: Flexible appearance and behavior
- **Interactive**: Gesture-based dismissal
- **Responsive**: Built-in scrolling for large content
- **Simple API**: Intuitive integration

## Requirements

- iOS 15.0+ / macOS 14.0+
- Swift 6.0+
- Xcode 15.0+

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/michaelharrigan/MHModal.git", from: "2.1.0")
]
```

## Usage

### Basic Example

```swift
import SwiftUI
import MHModal

struct ContentView: View {
    @State private var showModal = false
    
    var body: some View {
        Button("Show Modal") {
            showModal = true
        }
        .modal(isPresented: $showModal) {
            VStack(spacing: 20) {
                Text("Hello World!")
                    .font(.title)
                
                Button("Close") {
                    showModal = false
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}
```

### Customization

#### Appearance

```swift
.modal(
    isPresented: $showModal,
    appearance: .dark  // Built-in theme
) {
    Text("Dark theme modal")
}

// Custom appearance
.modal(
    isPresented: $showModal,
    appearance: ModalAppearance(
        background: .white,
        overlayColor: Color.black.opacity(0.4),
        cornerRadius: 24,
        showDragIndicator: true
    )
) {
    Text("Custom appearance")
}
```

#### Behavior

```swift
// Non-dismissible
.modal(
    isPresented: $showModal,
    behavior: .nonDismissible
) {
    Text("Programmatic dismiss only")
}

// Custom behavior
.modal(
    isPresented: $showModal,
    behavior: ModalBehavior(
        enableDragToDismiss: true,
        tapToDismiss: false
    )
) {
    Text("Custom behavior")
}
```

## Configuration Options

### Appearance Properties

| Property | Description |
|----------|-------------|
| `background` | Modal background color |
| `overlayColor` | Dimmed background overlay color |
| `cornerRadius` | Modal corner radius |
| `showDragIndicator` | Toggle for drag indicator visibility |
| `maxHeightRatio` | Maximum height ratio (0.0-1.0) |
| `sizeChangeAnimation` | Animation for size changes |

### Behavior Properties

| Property | Description |
|----------|-------------|
| `enableDragToDismiss` | Allow dismissal via dragging |
| `tapToDismiss` | Allow dismissal via overlay tap |
| `dismissVelocityThreshold` | Velocity threshold for dismissal |

## Documentation

API documentation is available in Xcode. Build the MHModal target, then go to Product > Build Documentation.

## License

MHModal is available under the MIT license.
