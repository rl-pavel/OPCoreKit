#if canImport(UIKit)
import UIKit

public extension UILabel {
  /// Adds support for Dynamic Type and applies the specified styling options.
  ///
  /// - Parameters:
  ///   - lineCount: `Int` for number of lines (default: `0`).
  ///   - lineBreaking: `NSLineBreakMode` for line break mode (default: `byWordWrapping`).
  func applyStyle(
    lineCount: Int = 0,
    lineBreaking: NSLineBreakMode = .byWordWrapping
  ) {
    numberOfLines = lineCount
    lineBreakMode = lineBreaking
    adjustsFontForContentSizeCategory = true
  }
  
  /// Adds support for Dynamic Type and applies the specified styling options.
  ///
  /// NOTE: This function will not apply the `tracking` or `lineSpacing`.
  /// To do that, using `NSAttributedString` is required.
  ///
  /// - Parameters:
  ///   - fontType: `FontType` which defines the `font`.
  ///   - color: `UIColor` for text color.
  ///   - alignment: `NSTextAlignment` for text alignment (default: `.left`).
  ///   - lineCount: `Int` for number of lines (default: `0`).
  ///   - lineBreaking: `NSLineBreakMode` for line break mode (default: `byWordWrapping`).
  func applyStyle<Font: FontProtocol>(
    _ fontType: FontType<Font>,
    color: UIColor,
    alignment: NSTextAlignment = .left,
    lineCount: Int = 0,
    lineBreaking: NSLineBreakMode = .byWordWrapping
  ) {
    applyStyle(lineCount: lineCount, lineBreaking: lineBreaking)
    font = fontType.platformFont
    textColor = color
    textAlignment = alignment
  }
}

public extension UIButton {
  /// Adds support for Dynamic Type and applies the specified styling options.
  ///
  /// - Parameters:
  ///   - lineCount: `Int` for number of lines (default: `0`).
  ///   - lineBreaking: `NSLineBreakMode` for line break mode (default: `byWordWrapping`).
  func applyStyle(
    lineCount: Int = 0,
    lineBreaking: NSLineBreakMode = .byWordWrapping
  ) {
    titleLabel?.numberOfLines = lineCount
    titleLabel?.lineBreakMode = lineBreaking
    titleLabel?.adjustsFontForContentSizeCategory = true
  }
  
  /// Adds support for Dynamic Type and applies the specified styling options.
  ///
  /// NOTE: This function will not apply the `tracking` or `lineSpacing`.
  /// To do that, using `NSAttributedString` is required.
  ///
  /// - Parameters:
  ///   - fontType: `FontType` which defines the `font`.
  ///   - color: `UIColor` for text color.
  ///   - alignment: `NSTextAlignment` for text alignment (default: `.left`).
  ///   - lineCount: `Int` for number of lines (default: `0`).
  ///   - lineBreaking: `NSLineBreakMode` for line break mode (default: `byWordWrapping`).
  func applyStyle<Font: FontProtocol>(
    _ fontType: FontType<Font>,
    color: UIColor,
    alignment: NSTextAlignment = .left,
    lineCount: Int = 0,
    lineBreaking: NSLineBreakMode = .byWordWrapping
  ) {
      applyStyle(lineCount: lineCount, lineBreaking: lineBreaking)
      setTitleColor(color, for: .normal)
      titleLabel?.font = fontType.platformFont
      titleLabel?.textAlignment = alignment
    }
}

public extension UITextField {
  /// Adds support for Dynamic Type.
  func applyStyle() {
    adjustsFontForContentSizeCategory = true
  }
  
  /// Adds support for Dynamic Type and applies the specified styling options.
  ///
  /// NOTE: This function will not apply the `tracking` or `lineSpacing`.
  /// To do that, using `NSAttributedString` is required.
  ///
  /// - Parameters:
  ///   - fontType: `FontType` which defines the `font`.
  ///   - color: `UIColor` for text color.
  ///   - alignment: `NSTextAlignment` for text alignment (default: `.left`).
  ///   - lineCount: `Int` for number of lines (default: `0`).
  ///   - lineBreaking: `NSLineBreakMode` for line break mode (default: `byWordWrapping`).
  func applyStyle<Font: FontProtocol>(
    _ fontType: FontType<Font>,
    color: UIColor,
    alignment: NSTextAlignment = .left) {
      applyStyle()
      font = fontType.platformFont
      textColor = color
      textAlignment = alignment
      defaultTextAttributes = .attributes(for: fontType, color: color, alignment: alignment)
      typingAttributes = .attributes(for: fontType, color: color, alignment: alignment)
    }
}

public extension UITextView {
  /// Adds support for Dynamic Type and applies the specified styling options.
  ///
  /// NOTE: This function will not apply the `tracking` or `lineSpacing`.
  /// To do that, using `NSAttributedString` is required.
  ///
  /// - Parameters:
  ///   - scrollable: `Bool` for scrolling (default: `true`).
  ///   - lineBreaking: `NSLineBreakMode` for line break mode (default: `byWordWrapping`).
  ///   - backgroundColor: `UIColor` for background color (default: `.clear`).
  func applyStyle(
    scrollable: Bool = true,
    lineBreaking: NSLineBreakMode = .byWordWrapping,
    backgroundColor: UIColor = .clear
  ) {
    textContainer.lineBreakMode = lineBreaking
    isScrollEnabled = scrollable
    self.backgroundColor = backgroundColor
    adjustsFontForContentSizeCategory = true
  }
  
  /// Adds support for Dynamic Type and applies the specified styling options.
  ///
  /// NOTE: This function will not apply the `tracking` or `lineSpacing`.
  /// To do that, using `NSAttributedString` is required.
  ///
  /// - Parameters:
  ///   - fontType: `FontType` which defines the `font`.
  ///   - color: `UIColor` for text color.
  ///   - alignment: `NSTextAlignment` for text alignment (default: `.left`).
  ///   - scrollable: `Bool` for scrolling (default: `true`).
  ///   - lineBreaking: `NSLineBreakMode` for line break mode (default: `byWordWrapping`).
  ///   - backgroundColor: `UIColor` for background color (default: `.clear`).
  func applyStyle<Font: FontProtocol>(
    _ fontType: FontType<Font>,
    color: UIColor,
    alignment: NSTextAlignment = .left,
    scrollable: Bool = true,
    lineBreaking: NSLineBreakMode = .byWordWrapping,
    backgroundColor: UIColor = .clear
  ) {
      applyStyle(scrollable: scrollable, lineBreaking: lineBreaking, backgroundColor: backgroundColor)
      font = fontType.platformFont
      textColor = color
      textAlignment = alignment
      typingAttributes = .attributes(for: fontType, color: color, alignment: alignment)
    }
}
#endif
