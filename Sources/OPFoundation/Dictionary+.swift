import Foundation

public extension Dictionary {
  var prettyJson: String? {
    guard let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted),
          let prettyString = String(data: data, encoding: .utf8) else {
            return nil
          }
    
    return prettyString
  }
  
  func merging(_ other: [Key: Value], keepingOldValue: Bool = false) -> [Key: Value] {
    self.merging(other) { oldValue, newValue in
      keepingOldValue ? oldValue : newValue
    }
  }
}

