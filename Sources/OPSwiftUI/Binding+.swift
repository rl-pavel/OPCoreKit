import OPFoundation
import SwiftUI

public extension Binding where Value: OptionalType {
  /// Converts a Binding with an optional values (`Binding<T?>`) to a non-optional (`Binding<T>`) with a default.
  func defaulting(to defaultValue: Value.Wrapped) -> Binding<Value.Wrapped> {
    .init(get: { self.wrappedValue.optional ?? defaultValue }, set: { self.wrappedValue.optional = $0 })
  }
  
  /// Converts a Binding with an optional values (`Binding<T?>`) to an optional `Binding<T>?` with unwrapped value.
  var unwrappedValue: Binding<Value.Wrapped>? {
    guard let unwrappedValue = wrappedValue.optional else {
      return nil
    }
    
    return .init(get: { unwrappedValue }, set: { wrappedValue.optional = $0 })
  }
}
