import OPFoundation
import SwiftUI

public extension Text {
  /// List of supported attributes:
  /// - foregroundColor
  /// - font
  /// - kern
  /// - strikethroughStyle/Color
  /// - baselineOffset
  /// - underlineStyle/Color
  init(_ string: NSAttributedString) {
    self.init("")
    
    string.enumerateAttributes(in: NSRange(location: 0, length: string.length), options: []) { attribute, range, _ in
      var styledText = Text(string.attributedSubstring(from: range).string)
      
      if let color = attribute[.foregroundColor] as? PlatformColor {
        styledText = styledText.foregroundColor(Color(color))
      }
      
      if let font = attribute[.font] as? PlatformFont {
        styledText = styledText.font(.init(font))
      }
      
      if let kern = attribute[.kern] as? CGFloat {
        styledText = styledText.kerning(kern)
      }
      
      
      if let strikeThrough = attribute[.strikethroughStyle] as? NSNumber, strikeThrough != 0 {
        if let strikeColor = (attribute[.strikethroughColor] as? PlatformColor) {
          styledText = styledText.strikethrough(true, color: Color(strikeColor))
        } else {
          styledText = styledText.strikethrough(true)
        }
      }
      
      if let baseline = attribute[.baselineOffset] as? NSNumber {
        styledText = styledText.baselineOffset(CGFloat(baseline.floatValue))
      }
      
      if let underline = attribute[.underlineStyle] as? NSNumber, underline != 0 {
        if let underlineColor = (attribute[.underlineColor] as? PlatformColor) {
          styledText = styledText.underline(true, color: Color(underlineColor))
        } else {
          styledText = styledText.underline(true)
        }
      }
      
      // swiftlint:disable:next shorthand_operator
      self = self + styledText
    }
  }
}
