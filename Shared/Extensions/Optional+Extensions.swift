import Foundation

/// `OptionalType`, which `Optional` conforms to, can be used for conditional conformance of any optionals
public protocol OptionalType: ExpressibleByNilLiteral {
  associatedtype Wrapped
  var optional: Wrapped? { get set }
}
extension Optional: OptionalType {
  public var optional: Wrapped? {
    get { return self }
    mutating set { self = newValue }
  }
}

/// A type-erased, non-generic optional protocol. Can be used for casting `as? AnyOptional`.
public protocol AnyOptional {
  var isNil: Bool { get set }
  var isNotNil: Bool { get set }
}
extension Optional: AnyOptional {
  public var isNil: Bool {
    get { self == nil }
    mutating set { self = newValue ? nil : self }
  }
  
  public var isNotNil: Bool {
    get { self != nil }
    mutating set { self = newValue ? self : nil }
  }
}

extension Optional where Wrapped: Collection {
  var isNilOrEmpty: Bool {
    return self?.isEmpty ?? true
  }
}

/// Operator useful for printing/logging optional values with a default string fallback
/// Usage: `print(someOptional?.someNonStringValue ??? "default string")`
infix operator ???: NilCoalescingPrecedence
public func ???<T>(optional: T?, defaultValue: @autoclosure () -> String) -> String {
  switch optional {
    case let value?: return String(describing: value)
    case nil: return defaultValue()
  }
}


// MARK: - Optional Comparable Operators

infix operator >? : NilCoalescingPrecedence
infix operator >=? : NilCoalescingPrecedence
infix operator <? : NilCoalescingPrecedence
infix operator <=? : NilCoalescingPrecedence
infix operator !=? : NilCoalescingPrecedence
infix operator ==? : NilCoalescingPrecedence

extension Optional where Wrapped: Comparable {
  /// Unwraps both sides, returning `false` if either is `nil`, then performs the comparison check.
  public static func >? (lhs: Wrapped?, rhs: Wrapped?) -> Bool {
    guard let lhs = lhs, let rhs = rhs else {
      return false
    }
    
    return lhs > rhs
  }
  
  /// Unwraps both sides, returning `false` if either is `nil`, then performs the comparison check.
  public static func >=? (lhs: Wrapped?, rhs: Wrapped?) -> Bool {
    guard let lhs = lhs, let rhs = rhs else {
      return false
    }
    
    return lhs >= rhs
  }
  
  /// Unwraps both sides, returning `false` if either is `nil`, then performs the comparison check.
  public static func <? (lhs: Wrapped?, rhs: Wrapped?) -> Bool {
    guard let lhs = lhs, let rhs = rhs else {
      return false
    }
    
    return lhs < rhs
  }
  
  /// Unwraps both sides, returning `false` if either is `nil`, then performs the comparison check.
  public static func <=? (lhs: Wrapped?, rhs: Wrapped?) -> Bool {
    guard let lhs = lhs, let rhs = rhs else {
      return false
    }
    
    return lhs <= rhs
  }
}

extension Optional where Wrapped: Equatable {
  /// Unwraps both sides, returning `false` if either is `nil`, then performs the equation check.
  public static func !=? (lhs: Wrapped?, rhs: Wrapped?) -> Bool {
    guard let lhs = lhs, let rhs = rhs else {
      return false
    }
    
    return lhs != rhs
  }
  
  /// Unwraps both sides, returning `false` if either is `nil`, then performs the equation check.
  public static func ==? (lhs: Wrapped?, rhs: Wrapped?) -> Bool {
    guard let lhs = lhs, let rhs = rhs else {
      return false
    }
    
    return lhs == rhs
  }
}
