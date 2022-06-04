import Foundation

public extension Encodable {
  func encoded(using jsonEncoder: JSONEncoder = .init()) throws -> Data {
    return try jsonEncoder.encode(self)
  }
  
  func encodedPlist(using plistEncoder: PropertyListEncoder = .init()) throws -> Data {
    return try plistEncoder.encode(self)
  }
}

public extension Decodable {
  static func decode(fromData data: Data, using jsonDecoder: JSONDecoder = .init()) throws -> Self {
    return try jsonDecoder.decode(Self.self, from: data)
  }
  
  static func decode(fromJson jsonObject: [String: Any], using jsonDecoder: JSONDecoder = .init()) throws -> Self {
    let data = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
    return try jsonDecoder.decode(Self.self, from: data)
  }
  
  static func decodePlist(
    fromData data: Data,
    using plistDecoder: PropertyListDecoder = .init(),
    with format: PropertyListSerialization.PropertyListFormat) throws -> Self {
      var format = format
      return try plistDecoder.decode(Self.self, from: data, format: &format)
  }
}


public extension PropertyListEncoder {
  static let binaryEncoder: PropertyListEncoder = update(.init()) {
    $0.outputFormat = .binary
  }
}

