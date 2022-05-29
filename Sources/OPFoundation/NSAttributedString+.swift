import Foundation

public extension NSAttributedString {
  typealias Attributes = [NSAttributedString.Key: Any]
  
  /// Creates an `NSAttributedString` with the specified map of strings to the desired attributes.
  ///
  /// ```
  /// NSAttributedString(
  ///   string: "7 red lines with green ink",
  ///   attributes: [.foregroundColor: UIColor.red],
  ///   attributedSubstrings: ["green ink": [.foregroundColor: UIColor.green]]
  /// )
  /// ```
  convenience init(
    string: String,
    attributes: Attributes? = nil,
    attributedSubstrings: [String?: Attributes]) {
      let mutableString = NSMutableAttributedString(string: string, attributes: attributes)
      
      for (substring, attributes) in attributedSubstrings {
        guard let substring = substring?.nonEmpty,
              let range = string.range(of: substring) else {
          continue
        }
        
        mutableString.addAttributes(attributes, range: NSRange(range, in: string))
      }
      
      self.init(attributedString: mutableString)
    }
}
