import Foundation

public extension Encodable {
  func encoded(using encoder: JSONEncoder = .init()) throws -> Data {
    return try encoder.encode(self)
  }
}

public extension Decodable {
  static func decode(fromData data: Data, using decoder: JSONDecoder = .init()) throws -> Self {
    return try decoder.decode(Self.self, from: data)
  }
  
  static func decode(fromJson jsonObject: [String: Any], using decoder: JSONDecoder = .init()) throws -> Self {
    let data = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
    return try decoder.decode(Self.self, from: data)
  }
}
