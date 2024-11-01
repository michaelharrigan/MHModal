# MHModal

MHModal is a highly customizable, interactive modal presentation component for SwiftUI that features smooth animations, gesture-based dismissal, and dynamic content sizing. It supports multiple detents (like iOS sheets), scrollable content, and safe area awareness.

## Features

- 🎨 Highly customizable appearance
- 📱 iOS-style sheet presentation with multiple detents
- 🔄 Smooth spring animations
- 👆 Interactive gesture-based dismissal
- 📜 Automatic scrolling for overflow content
- 🔒 Safe area awareness
- 📐 Dynamic content sizing

## Requirements

- iOS 15.0+ / macOS 12.0+
- Swift 5.9+
- Xcode 15.0+

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/YOUR_USERNAME/MHModal.git", from: "1.0.0")
]
```

Or add it directly through Xcode:
1. File > Add Packages
2. Enter the repository URL: https://github.com/YOUR_USERNAME/MHModal.git

## Usage

### Basic Usage

```swift
import SwiftUI
import MHModal

struct ContentView: View {
    @State private var showModal = false
    
    var body: some View {
        Button("Show Modal") {
            showModal = true
        }
        .mhModal(isPresented: $showModal) {
            VStack {
                Text("Modal Content")
                Button("Close") {
                    showModal = false
                }
            }
            .padding()
        }
    }
}
```

### Custom Configuration

```swift
.mhModal(
    isPresented: $showModal,
    configuration: MHModalConfiguration(
        horizontalPadding: 16,
        cornerRadius: 24,
        backgroundColor: .white,
        dragIndicatorColor: .blue.opacity(0.3),
        availableDetents: [.medium, .large],
        enableDragToDismiss: true
    )
) {
    YourModalContent()
}
```

### Available Detents

MHModal supports three types of detents:
- `.medium` - 50% of available height
- `.large` - 85% of available height
- `.custom(height:)` - Custom height multiplier

```swift
// Example with multiple detents
.mhModal(
    isPresented: $showModal,
    configuration: MHModalConfiguration(
        availableDetents: [.medium, .large]
    )
) {
    YourModalContent()
}
```

### Configuration Options

```swift
public struct MHModalConfiguration {
    let horizontalPadding: CGFloat
    let bottomPadding: CGFloat
    let cornerRadius: CGFloat
    let backgroundColor: Color
    let dragIndicatorColor: Color
    let showDragIndicator: Bool
    let availableDetents: [MHModalDetent]
    let enableDragToDismiss: Bool
}
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MHModal is available under the MIT license.