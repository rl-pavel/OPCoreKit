import SwiftUI

public extension Binding where Value: OptionalType {
  /// Converts a Binding with an optional values (`Binding<T?>`) to a non-optional (`Binding<T>`) with a default.
  func defaulting(to defaultValue: Value.Wrapped) -> Binding<Value.Wrapped> {
    .init(get: { self.wrappedValue.optional ?? defaultValue }, set: { self.wrappedValue.optional = $0 })
  }
}
