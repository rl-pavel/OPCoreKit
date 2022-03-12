import SwiftUI
#if canImport(UIKit)
import UIKit
#endif
#if canImport(AppKit)
import AppKit
#endif

/// A type that defines a set of text styles used in the app.
public struct TextStyle<Font: FontType> {
  private let fontType: Font

  public var font: SwiftUI.Font { fontType.font }
  public var platformFont: PlatformFont { fontType.platformFont }
  
  public var lineHeight: CGFloat
  public var tracking: CGFloat
  
  /// 34pts regular.
  public static var largeTitle: TextStyle<SystemFont> {
    .init(style: .largeTitle, weight: .regular, lineHeight: 0, tracking: 0.40)
  }

  /// 24pts regular.
  static var title1: TextStyle<SystemFont> {
    .init(style: .title1, weight: .regular, lineHeight: 0, tracking: 0.07)
  }

  /// 22pts regular.
  static var title2: TextStyle<SystemFont> {
    .init(style: .title2, weight: .regular, lineHeight: 0, tracking: -0.26)
  }

  /// 20pts regular.
  static var title3: TextStyle<SystemFont> {
    .init(style: .title3, weight: .regular, lineHeight: 0, tracking: -0.45)
  }

  /// 17pts semibold.
  static var headline: TextStyle<SystemFont> {
    .init(style: .headline, weight: .semibold, lineHeight: 0, tracking: -0.43)
  }

  /// 17pts regular.
  static var body: TextStyle<SystemFont> {
    .init(style: .body, weight: .regular, lineHeight: 0, tracking: -0.43)
  }

  /// 16pts regular.
  static var callout: TextStyle<SystemFont> {
    .init(style: .callout, weight: .regular, lineHeight: 0, tracking: -0.31)
  }

  /// 15pts regular.
  static var subheadline: TextStyle<SystemFont> {
    .init(style: .subheadline, weight: .regular, lineHeight: 0, tracking: -0.23)
  }

  /// 13pts regular.
  static var footnote: TextStyle<SystemFont> {
    .init(style: .footnote, weight: .regular, lineHeight: 0, tracking: -0.15)
  }

  /// 12pts regular.
  static var caption1: TextStyle<SystemFont> {
    .init(style: .caption1, weight: .regular, lineHeight: 0, tracking: 0)
  }

  /// 11pts regular.
  static var caption2: TextStyle<SystemFont> {
    .init(style: .caption2, weight: .regular, lineHeight: 0, tracking: 0.06)
  }


  private init(style: TypeStyle, weight: Font.WeightType, lineHeight: CGFloat, tracking: CGFloat) {
    self.fontType = .init(style: style, weight: weight)
    self.lineHeight = lineHeight / 100
    self.tracking = tracking
  }
}


// MARK: - UIKit Styling

#if canImport(UIKit)
public extension UILabel {
  func applyStyle() {
    numberOfLines = 0
    lineBreakMode = .byWordWrapping
    adjustsFontForContentSizeCategory = true
  }
  
  /// ⚠️ This extension will not apply the tracking/line spacing, using `NSAttributedString` is required.
  func applyStyle<Font: FontType>(
    _ style: TextStyle<Font>,
    color: UIColor,
    alignment: NSTextAlignment = .left) {
      applyStyle()
      font = style.platformFont
      textColor = color
      textAlignment = alignment
    }
}

public extension UIButton {
  func applyStyle() {
    titleLabel?.numberOfLines = 0
    titleLabel?.lineBreakMode = .byWordWrapping
    titleLabel?.adjustsFontForContentSizeCategory = true
  }
  
  /// ⚠️ This extension will not apply the tracking/line spacing, using `NSAttributedString` is required.
  func applyStyle<Font: FontType>(
    _ style: TextStyle<Font>,
    color: UIColor,
    alignment: NSTextAlignment = .left) {
      applyStyle()
      setTitleColor(color, for: .normal)
      titleLabel?.font = style.platformFont
      titleLabel?.textAlignment = alignment
    }
}

public extension UITextField {
  func applyStyle() {
    adjustsFontForContentSizeCategory = true
  }
  
  func applyStyle<Font: FontType>(
    _ style: TextStyle<Font>,
    color: UIColor,
    alignment: NSTextAlignment = .left) {
      applyStyle()
      font = style.platformFont
      textColor = color
      textAlignment = alignment
      defaultTextAttributes = .attributes(for: style, color: color, alignment: alignment)
      typingAttributes = .attributes(for: style, color: color, alignment: alignment)
    }
}

public extension UITextView {
  func applyStyle() {
    textContainer.lineBreakMode = .byWordWrapping
    isScrollEnabled = false
    backgroundColor = .clear
    adjustsFontForContentSizeCategory = true
  }
  
  func applyStyle<Font: FontType>(
    _ style: TextStyle<Font>,
    color: UIColor,
    alignment: NSTextAlignment = .left) {
      applyStyle()
      font = style.platformFont
      textColor = color
      textAlignment = alignment
      typingAttributes = .attributes(for: style, color: color, alignment: alignment)
    }
}
#endif

public extension Text {
  func applyStyle<Font: FontType>(_ style: TextStyle<Font>) -> some View {
    return self
      .font(style.font)
      .tracking(style.tracking)
      .lineSpacing(style.lineHeight)
  }
  
  func applyStyle<Font: FontType>(_ style: TextStyle<Font>, color: Color) -> some View {
    return applyStyle(style)
      .foregroundColor(color)
  }
  
  func applyStyle<Font: FontType>(_ style: TextStyle<Font>, alignment: TextAlignment) -> some View {
    return applyStyle(style)
      .multilineTextAlignment(alignment)
  }
  
  func applyStyle<Font: FontType>(_ style: TextStyle<Font>, color: Color, alignment: TextAlignment) -> some View {
    return applyStyle(style, color: color)
      .multilineTextAlignment(alignment)
  }
}

public extension View {
  /// ⚠️ This extension will not apply the tracking/line spacing, consider using `Text` styling directly.
  @_disfavoredOverload
  func applyStyle<Font: FontType>(_ style: TextStyle<Font>) -> some View {
    return self.font(style.font)
  }
  
  /// ⚠️ This extension will not apply the tracking/line spacing, consider using `Text` styling directly.
  @_disfavoredOverload
  func applyStyle<Font: FontType>(_ style: TextStyle<Font>, color: Color) -> some View {
    return applyStyle(style)
      .foregroundColor(color)
  }
  
  /// ⚠️ This extension will not apply the tracking/line spacing, consider using `Text` styling directly.
  @_disfavoredOverload
  func applyStyle<Font: FontType>(_ style: TextStyle<Font>, alignment: TextAlignment) -> some View {
    return applyStyle(style)
      .multilineTextAlignment(alignment)
  }
  
  /// ⚠️ This extension will not apply the tracking/line spacing, consider using `Text` styling directly.
  @_disfavoredOverload
  func applyStyle<Font: FontType>(
    _ style: TextStyle<Font>,
    color: Color,
    alignment: TextAlignment) -> some View {
      return applyStyle(style, color: color)
        .multilineTextAlignment(alignment)
    }
}


fileprivate extension NSMutableParagraphStyle {
  convenience init<Font: FontType>(style: TextStyle<Font>) {
    self.init()
    self.lineSpacing = style.lineHeight
  }
  
  convenience init<Font: FontType>(style: TextStyle<Font>, alignment: NSTextAlignment) {
    self.init()
    
    self.lineSpacing = style.lineHeight
    self.alignment = alignment
  }
}

public extension Dictionary where Key == NSAttributedString.Key, Value: Any {
  static func attributes<Font: FontType>(for style: TextStyle<Font>) -> [NSAttributedString.Key: Any] {
    [
      .font: style.platformFont,
      .tracking: style.tracking,
      .paragraphStyle: NSMutableParagraphStyle(style: style)
    ]
  }
  
  static func attributes<Font: FontType>(
    for style: TextStyle<Font>,
    color: PlatformColor) -> [NSAttributedString.Key: Any] {
      attributes(for: style)
        .merging([.foregroundColor: color])
    }
  
  static func attributes<Font: FontType>(
    for style: TextStyle<Font>,
    alignment: NSTextAlignment) -> [NSAttributedString.Key: Any] {
      attributes(for: style)
        .merging([.paragraphStyle: NSMutableParagraphStyle(style: style, alignment: alignment)])
    }
  
  static func attributes<Font: FontType>(
    for style: TextStyle<Font>,
    color: PlatformColor,
    alignment: NSTextAlignment) -> [NSAttributedString.Key: Any] {
      attributes(for: style, alignment: alignment)
        .merging([.foregroundColor: color])
    }
}

public extension NSAttributedString {
  convenience init(_ string: String) {
    self.init(string: string)
  }
  
  convenience init<Font: FontType>(_ string: String, style: TextStyle<Font>) {
    self.init(string: string, attributes: .attributes(for: style))
  }

  convenience init<Font: FontType>(_ string: String, style: TextStyle<Font>, color: PlatformColor) {
    self.init(string: string, attributes: .attributes(for: style, color: color))
  }
  
  convenience init<Font: FontType>(_ string: String, style: TextStyle<Font>, alignment: NSTextAlignment) {
    self.init(string: string, attributes: .attributes(for: style, alignment: alignment))
  }
  
  convenience init<Font: FontType>(
    _ string: String,
    style: TextStyle<Font>,
    color: PlatformColor,
    alignment: NSTextAlignment) {
      self.init(string: string, attributes: .attributes(for: style, color: color, alignment: alignment))
  }
}

extension NSMutableAttributedString {
  func applyStyle<Font: FontType>(_ style: TextStyle<Font>, to range: NSRange? = nil) {
    addAttributes(
      .attributes(for: style),
      range: range ?? NSRange(location: 0, length: string.count)
    )
  }
  
  func applyStyle<Font: FontType>(_ style: TextStyle<Font>, color: PlatformColor, to range: NSRange? = nil) {
    addAttributes(
      .attributes(for: style, color: color),
      range: range ?? NSRange(location: 0, length: string.count)
    )
  }
  
  func applyStyle<Font: FontType>(_ style: TextStyle<Font>, alignment: NSTextAlignment, to range: NSRange? = nil) {
    addAttributes(
      .attributes(for: style, alignment: alignment),
      range: range ?? NSRange(location: 0, length: string.count)
    )
  }
  
  func applyStyle<Font: FontType>(
    _ style: TextStyle<Font>,
    color: PlatformColor,
    alignment: NSTextAlignment,
    to range: NSRange? = nil) {
      addAttributes(
        .attributes(for: style, color: color, alignment: alignment),
        range: range ?? NSRange(location: 0, length: string.count)
      )
  }
}


#if DEBUG
struct TextStyles_Previews: PreviewProvider {
  struct StylePreview: Identifiable {
    var id: UUID { .init() }
    
    let style: TextStyle<SystemFont>
    let maxWidth: CGFloat
    
    static let text: String = "The quick brown fox jumps over the lazy dog"
    static let allStyles: [StylePreview] = [
      .init(style: .largeTitle, maxWidth: 360),
      .init(style: .title1, maxWidth: 360),
      .init(style: .title2, maxWidth: 360),
      .init(style: .title3, maxWidth: 360),
      
      .init(style: .headline, maxWidth: 280),
      .init(style: .body, maxWidth: 280),
      .init(style: .callout, maxWidth: 280),
      .init(style: .subheadline, maxWidth: 280),
      
      .init(style: .footnote, maxWidth: 200),
      .init(style: .caption1, maxWidth: 200),
      .init(style: .caption2, maxWidth: 200),
    ]
  }

  static var previews: some View {
    VStack(alignment: .leading, spacing: 0) {
      ForEach(StylePreview.allStyles) {
        Text("The quick brown fox jumps over the lazy dog")
          .applyStyle($0.style)
          .fixedSize(horizontal: false, vertical: true)
          .frame(maxWidth: $0.maxWidth, alignment: .leading)
          .padding(.bottom, .x8)
          .background(Color.black.opacity(0.1))
      }
    }
    .padding(.horizontal, .x8)
    .frame(maxSize: .infinity, alignment: .topLeading)
  }
}
#endif
