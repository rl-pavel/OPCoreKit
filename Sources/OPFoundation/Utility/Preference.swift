import Foundation

/// A property wrapped for storing `Codable` values in `UserDefaults.standard`.
///
/// Example usage:
/// ```
/// @Preference(key: "someValue", defaultValue: "default value")
/// var someValue: String
///
/// @Preference(key: "optionalValue")
/// var optionalValue: String?
/// ```
@propertyWrapper
public struct Preference<Value: Codable> {
  
  // MARK: - Properties
  
  let key: String
  let defaultValue: Value
  
  private var userDefaults = UserDefaults.standard
  
  public var wrappedValue: Value {
    get {
      let data = userDefaults.object(forKey: key) as? Data
      let decodedValue = data.flatMap { try? JSONDecoder().decode(Value.self, from: $0) }
      return decodedValue ?? defaultValue
    }
    
    set {
      // Clear out the object if the new value is an Optional and nil.
      if let optionalValue = newValue as? any OptionalType, optionalValue.isNil {
        userDefaults.removeObject(forKey: key)
        return
      }
      
      let encodedValue = try? JSONEncoder().encode(newValue)
      userDefaults.set(encodedValue ?? newValue, forKey: key)
    }
  }
  
  
  // MARK: - Inits
  
  init(key: String, defaultValue: Value) {
    self.key = key
    self.defaultValue = defaultValue
  }
  
  init(key: String) where Value: OptionalType {
    self.key = key
    self.defaultValue = nil
  }
  
  
  // MARK: - Functions
  
  mutating func resetToDefault(if shouldReset: Bool = true) {
    guard shouldReset else { return }
    wrappedValue = defaultValue
  }
}
