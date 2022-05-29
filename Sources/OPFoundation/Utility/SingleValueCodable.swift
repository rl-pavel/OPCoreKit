import Foundation

/// A type that can convert itself into and out of an external representation's single value.
///
/// Example:
/// ```
/// struct VehicleType: SingleValueCodable {
///   let value: String
///   static let convertible: VehicleType = .init(value: "convertible")
/// }
/// ```
public typealias SingleValueCodable = SingleValueEncodable & SingleValueDecodable

// MARK: - Encodable

public protocol SingleValueEncodable: Encodable {
  associatedtype Value: Encodable
  var value: Value { get }
  init(value: Value)
}

extension SingleValueEncodable {
  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(value)
  }
}


// MARK: - Decodable

public protocol SingleValueDecodable: Decodable {
  associatedtype Value: Decodable
  var value: String { get }
  init(value: Value)
}

extension SingleValueDecodable {
  init(from decoder: Decoder) throws {
    self.init(value: try decoder.singleValueContainer().decode(Value.self))
  }
}
