import SwiftUI

/// A wrapper view that provides a mutable Binding to its content closure.
///
/// Useful in Xcode Previews for interactive previews of views that take a Binding.
/// Credit: https://twitter.com/olebegemann/status/1565707085849010176
#if DEBUG
public struct Stateful<Value, Content: View> {
  var content: (Binding<Value>) -> Content
  @State private var state: Value
  
  public init(initialState: Value, @ViewBuilder content: @escaping (Binding<Value>) -> Content) {
    self._state = State(initialValue: initialState)
    self.content = content
  }
}

extension Stateful: View {
  public var body: some View {
    content($state)
  }
}


struct Stateful_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Text("Interactive Previews for Bindings!")
        .font(.headline)
      Stateful(initialState: true) { $state in
        Toggle("Toggle", isOn: $state)
      }
      Stateful(initialState: 0.25) { $state in
        HStack {
          Text(String(format: "%.2f", state))
            .padding(.trailing, 20)
          Slider(value: $state, in: 0...1) {
            Text("Percentage")
          }
        }
        .font(.body.monospacedDigit())
      }
    }
    .padding()
    .previewLayout(.fixed(width: 300, height: 300))
  }
}
#endif
