import Foundation

public extension NSAttributedString {
  typealias Attributes = [NSAttributedString.Key: Any]
  
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
