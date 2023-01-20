import OPFoundation
import SwiftUI

public extension Binding where Value: OptionalType {
    /// Returns a binding with unwrapped (non-nil) value using the provided `defaultValue` fallback.
    func defaulting(to defaultValue: Value.Wrapped) -> Binding<Value.Wrapped> {
        .init(get: { self.wrappedValue.optional ?? defaultValue }, set: { self.wrappedValue.optional = $0 })
    }

    /// Returns an optional binding with unwrapped value (`Binding<T?>` -> `Binding<T>?`).
    /// The result will be `nil` if the wrapped value is `nil`.
    var unwrappedValue: Binding<Value.Wrapped>? {
        guard let unwrappedValue = wrappedValue.optional else {
            return nil
        }

        return .init(get: { unwrappedValue }, set: { wrappedValue.optional = $0 })
    }
}
