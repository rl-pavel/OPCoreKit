import Foundation
import CoreGraphics

extension String {
  func height<Font: FontType>(withConstrainedWidth width: CGFloat, style: TextStyle<Font>) -> CGFloat {
    let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
    let boundingBox = self.boundingRect(
      with: constraintRect,
      options: [.usesLineFragmentOrigin, .usesFontLeading],
      attributes: .attributes(for: style),
      context: nil)
    
    return boundingBox.height
  }
  
  func width<Font: FontType>(withConstrainedHeight height: CGFloat, style: TextStyle<Font>) -> CGFloat {
    let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
    let boundingBox = self.boundingRect(
      with: constraintRect,
      options: [.usesLineFragmentOrigin, .usesFontLeading],
      attributes: .attributes(for: style),
      context: nil)
    
    return boundingBox.width
  }
}


extension NSAttributedString {
  /// Note: for accurate calculation, the string must have the font embedded as an attribute.
  func height(withConstrainedWidth width: CGFloat) -> CGFloat {
    let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
    let boundingBox = boundingRect(
      with: constraintRect,
      options: [.usesLineFragmentOrigin, .usesFontLeading],
      context: nil)
    
    return boundingBox.height
  }
  
  /// Note: for accurate calculation, the string must have the font embedded as an attribute.
  func width(withConstrainedHeight height: CGFloat) -> CGFloat {
    let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
    let boundingBox = boundingRect(
      with: constraintRect,
      options: [.usesLineFragmentOrigin, .usesFontLeading],
      context: nil)
    
    return boundingBox.width
  }
  
  typealias Attributes = [NSAttributedString.Key: Any]
  typealias AttributedSubstring = [String?: Attributes]
  
  convenience init(
    string: String,
    attributes: Attributes? = nil,
    attributedSubstrings: AttributedSubstring) {
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
