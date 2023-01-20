import Foundation
import PlatformKit

public extension NSAttributedString {
  /// Creates an attributed string with no attribute information.
  convenience init(_ string: String) {
    self.init(string: string)
  }
  
  /// Creates an attributed string with `font`, `tracking` and `paragraphStyle` (`lineSpacing`)
  /// attributes for the given `FontType`.
  convenience init<Font: FontProtocol>(_ string: String, fontType: FontType<Font>) {
    self.init(string: string, attributes: .attributes(for: fontType))
  }
  
  /// Creates an attributed string with `font`, `tracking` and `paragraphStyle` (`lineSpacing`)
  /// and `foregroundColor` attributes for the given `FontType`.
  convenience init<Font: FontProtocol>(_ string: String, fontType: FontType<Font>, color: PlatformColor) {
    self.init(string: string, attributes: .attributes(for: fontType, color: color))
  }
  
  /// Creates an attributed string with `font`, `tracking` and `paragraphStyle` (`lineSpacing` + `alignment`)
  /// attributes for the given `FontType`.
  convenience init<Font: FontProtocol>(_ string: String, fontType: FontType<Font>, alignment: NSTextAlignment) {
    self.init(string: string, attributes: .attributes(for: fontType, alignment: alignment))
  }
  
  /// Creates an attributed string with `font`, `tracking` and `paragraphStyle` (`lineSpacing` + `alignment`)
  /// and `foregroundColor` attributes for the given `FontType`.
  convenience init<Font: FontProtocol>(
    _ string: String,
    fontType: FontType<Font>,
    color: PlatformColor,
    alignment: NSTextAlignment) {
      self.init(string: string, attributes: .attributes(for: fontType, color: color, alignment: alignment))
    }
}

public extension NSMutableAttributedString {
  /// Creates a mutable attributed string with `font`, `tracking` and `paragraphStyle` (`lineSpacing`)
  /// attributes for the given `FontType`.
  func applyStyle<Font: FontProtocol>(_ fontType: FontType<Font>, to range: NSRange? = nil) {
    addAttributes(
      .attributes(for: fontType),
      range: range ?? NSRange(location: 0, length: string.count)
    )
  }
  
  /// Creates a mutable attributed string with `font`, `tracking` and `paragraphStyle` (`lineSpacing`)
  /// and `foregroundColor` attributes for the given `FontType`.
  func applyStyle<Font: FontProtocol>(_ fontType: FontType<Font>, color: PlatformColor, to range: NSRange? = nil) {
    addAttributes(
      .attributes(for: fontType, color: color),
      range: range ?? NSRange(location: 0, length: string.count)
    )
  }
  
  /// Creates a mutable attributed string with `font`, `tracking` and `paragraphStyle` (`lineSpacing` + `alignment`)
  /// attributes for the given `FontType`.
  func applyStyle<Font: FontProtocol>(_ fontType: FontType<Font>, alignment: NSTextAlignment, to range: NSRange? = nil) {
    addAttributes(
      .attributes(for: fontType, alignment: alignment),
      range: range ?? NSRange(location: 0, length: string.count)
    )
  }
  
  /// Creates a mutable attributed string with `font`, `tracking` and `paragraphStyle` (`lineSpacing` + `alignment`)
  /// and `foregroundColor` attributes for the given `FontType`.
  func applyStyle<Font: FontProtocol>(
    _ fontType: FontType<Font>,
    color: PlatformColor,
    alignment: NSTextAlignment,
    to range: NSRange? = nil) {
      addAttributes(
        .attributes(for: fontType, color: color, alignment: alignment),
        range: range ?? NSRange(location: 0, length: string.count)
      )
    }
}

public extension Dictionary where Key == NSAttributedString.Key, Value: Any {
  /// Creates `font`, `tracking` and `paragraphStyle` (`lineSpacing`) attributes for the given `TextStyle`.
  static func attributes<Font: FontProtocol>(for fontType: FontType<Font>) -> [NSAttributedString.Key: Any] {
    [
      .font: fontType.platformFont,
      .tracking: fontType.tracking,
      .paragraphStyle: NSMutableParagraphStyle(fontType: fontType)
    ]
  }
  
  /// Creates `font`, `tracking` and `paragraphStyle` (`lineSpacing`) and `foregroundColor` attributes
  /// for the given `FontType`.
  static func attributes<Font: FontProtocol>(
    for fontType: FontType<Font>,
    color: PlatformColor) -> [NSAttributedString.Key: Any] {
      attributes(for: fontType)
        .merging([.foregroundColor: color]) { _, new in new }
    }
  
  /// Creates `font`, `tracking` and `paragraphStyle` (`lineSpacing` + `alignment`) attributes
  /// for the given `FontType`.
  static func attributes<Font: FontProtocol>(
    for fontType: FontType<Font>,
    alignment: NSTextAlignment) -> [NSAttributedString.Key: Any] {
      attributes(for: fontType)
        .merging([.paragraphStyle: NSMutableParagraphStyle(fontType: fontType, alignment: alignment)])  { _, new in new }
    }
  
  /// Creates `font`, `tracking` and `paragraphStyle` (`lineSpacing` + `alignment`) and `foregroundColor` attributes
  /// for the given `FontType`.
  static func attributes<Font: FontProtocol>(
    for fontType: FontType<Font>,
    color: PlatformColor,
    alignment: NSTextAlignment) -> [NSAttributedString.Key: Any] {
      attributes(for: fontType, alignment: alignment)
        .merging([.foregroundColor: color]) { _, new in new }
    }
}

public extension NSMutableParagraphStyle {
  /// Creates a paragraph style with `lineSpacing` for the given `FontType`.
  convenience init<Font: FontProtocol>(fontType: FontType<Font>) {
    self.init()
    self.lineSpacing = fontType.lineSpacing
  }
  
  /// Creates a paragraph style with `lineSpacing` and `alignment` for the given `FontType`.
  convenience init<Font: FontProtocol>(fontType: FontType<Font>, alignment: NSTextAlignment) {
    self.init()
    self.lineSpacing = fontType.lineSpacing
    self.alignment = alignment
  }
}
