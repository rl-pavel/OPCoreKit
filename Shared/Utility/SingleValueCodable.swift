import Foundation

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
