import XCTest
import SwiftUI
@testable import MHModal

@MainActor
final class ViewModalExtensionTests: XCTestCase {
    // Test view struct for testing the modal modifier
    struct TestView: View {
        @State var showModal = false

        var body: some View {
            Button("Show Modal") {
                showModal.toggle()
            }
            .modal(isPresented: $showModal) {
                Text("Modal Content")
            }
        }
    }

    // Test view struct for testing custom parameters
    struct CustomParamsTestView: View {
        @State var showModal = false

        var body: some View {
            Button("Show Modal") {
                showModal.toggle()
            }
            .modal(
                isPresented: $showModal,
                appearance: .dark,
                behavior: .nonDismissible
            ) {
                Text("Modal Content")
            }
        }
    }

    // Test view using legacy API
    struct LegacyTestView: View {
        @State var showModal = false

        var body: some View {
            Button("Show Modal") {
                showModal.toggle()
            }
            .mhModal(isPresented: $showModal) {
                Text("Modal Content")
            }
        }
    }

    func testViewModifierExistence() {
        // Create a test view using the modal modifier
        let testView = TestView()

        // If this compiles, then the modifier exists
        XCTAssertNotNil(testView)
    }

    func testModalWithCustomParameters() {
        // Create a test view with custom parameters
        let testView = CustomParamsTestView()

        // If this compiles, then the modifier with custom parameters works
        XCTAssertNotNil(testView)
    }

    func testLegacyViewModifier() {
        // Create a test view using the legacy mhModal modifier
        let testView = LegacyTestView()

        // If this compiles, then the legacy modifier still works
        XCTAssertNotNil(testView)
    }

    func testFullViewHierarchy() {
        // Test that a view with the modal modifier builds correctly
        let view = Text("Test")
            .modal(isPresented: .constant(true)) {
                Text("Modal Content")
            }

        // Verify the view exists
        XCTAssertNotNil(view)
    }
}
