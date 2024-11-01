# MHModal

Elegant, adaptive modals for SwiftUI.

[![Swift](https://img.shields.io/badge/Swift-5.7-orange.svg)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-15.0+-blue.svg)](https://developer.apple.com/ios/)
[![macOS](https://img.shields.io/badge/macOS-13.0+-blue.svg)](https://developer.apple.com/macos/)
[![Tests](https://img.shields.io/badge/Tests-Passing-brightgreen.svg)](https://github.com/michaelharrigan/MHModal/actions)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

## Overview

MHModal provides floating modals that automatically adapt to content size with natural gesture controls. Built for iOS and macOS apps with a focus on simplicity and flexibility.

## Features

- Content-aware sizing that adapts dynamically 
- Natural gesture-based interactions
- Customizable appearance with built-in themes
- Flexible behavior configuration
- Simple, intuitive API

## Installation

```swift
.package(url: "https://github.com/michaelharrigan/MHModal.git", branch: "master")
```

## Basic Usage

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
            Text("Hello World!")
                .padding()
        }
    }
}
```

## Customization

### Appearance

```swift
// Use built-in themes
.mhModal(isPresented: $showModal, appearance: .dark)

// Or customize each aspect
.mhModal(
    isPresented: $showModal,
    appearance: ModalAppearance(
        background: .white,
        cornerRadius: 24,
        showDragIndicator: true
    )
)
```

### Behavior

```swift
// Non-dismissible modal
.mhModal(
    isPresented: $showModal,
    behavior: .nonDismissible
)

// Custom dismissal options
.mhModal(
    isPresented: $showModal,
    behavior: ModalBehavior(
        enableDragToDismiss: true,
        tapToDismiss: false
    )
)
```

## Requirements

- iOS 15.0+ / macOS 14.0+
- Swift 5.7+

## Documentation

For detailed API documentation, build the MHModal target in Xcode and select Product > Build Documentation.

## License

Available under the MIT license.
