import Foundation

/// A property wrapped for storing `Codable` values in `UserDefaults.standard`.
///
/// Example usage:
///
///     @Preference(key: "someValue", defaultValue: "default value")
///     var someValue: String
///
///     @Preference(key: "optionalValue")
///     var optionalValue: String?
///
@propertyWrapper
public struct Preference<Value: Codable> {
  
  // MARK: - Properties
  
  enum StorageType {
    case defaults
  }
  
  
  // MARK: - Properties
  
  let storageType: StorageType
  let key: String
  let defaultValue: Value
  
  private var userDefaults = UserDefaults.standard
  
  public var wrappedValue: Value {
    get {
      let data: Data?
      
      switch storageType {
      case .defaults:
        data = userDefaults.object(forKey: key) as? Data
      }
      
      let decodedValue = data.flatMap { try? JSONDecoder().decode(Value.self, from: $0) }
      return decodedValue ?? defaultValue
    }
    
    set {
      // Clear out the object if the new value is an Optional and nil.
      if let optionalValue = newValue as? AnyOptional, optionalValue.isNil {
        userDefaults.removeObject(forKey: key)
        return
      }
      
      let encodedValue = try? JSONEncoder().encode(newValue)
      
      switch storageType {
      case .defaults:
        userDefaults.set(encodedValue ?? newValue, forKey: key)
      }
    }
  }
  
  
  // MARK: - Inits
  
  init(_ storage: StorageType = .defaults, key: String, defaultValue: Value) {
    self.storageType = storage
    self.key = key
    self.defaultValue = defaultValue
  }
  
  init(_ storage: StorageType = .defaults, key: String) where Value: OptionalType {
    self.storageType = storage
    self.key = key
    self.defaultValue = nil
  }
  
  
  // MARK: - Functions
  
  mutating func resetToDefault(if shouldReset: Bool = true) {
    guard shouldReset else { return }
    wrappedValue = defaultValue
  }
}
