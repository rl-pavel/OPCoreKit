import UIKit
import SwiftUI

/// A type that defines a font that can be used to create various Dynamic Type text styles.
public protocol FontType {
  associatedtype WeightType
  var style: UIFont.TextStyle { get }
  var weight: WeightType { get }
  
  init(style: UIFont.TextStyle, weight: WeightType)
  
  var uiFont: UIFont { get }
  var font: Font { get }
}


// MARK: - Fonts

public struct SystemFont: FontType {
  public var style: UIFont.TextStyle
  public var weight: UIFont.Weight
  
  public var uiFont: UIFont { .dynamicSystemUIFont(with: style, weight: weight) }
  public var font: Font { .dynamicSystemFont(with: style, weight: weight) }
  
  public init(style: UIFont.TextStyle, weight: UIFont.Weight) {
    self.style = style
    self.weight = weight
  }
}


// MARK: - Helpers

extension UIFont {
  /// Creates a dynamic (accessible) system font based on TextStyle and Weight.
  static func dynamicSystemUIFont(with style: TextStyle, weight: Weight) -> UIFont {
    let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
    let fontMetrics = UIFontMetrics(forTextStyle: style)
    let baseFont = UIFont.systemFont(ofSize: fontDescriptor.pointSize, weight: weight)
    return fontMetrics.scaledFont(for: baseFont)
  }
  
  /// Creates a dynamic (accessible) custom font based on TextStyle and font name (which defines the weight).
  static func dynamicUIFont(with style: TextStyle, name: String) -> UIFont {
    let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
    let fontMetrics = UIFontMetrics(forTextStyle: style)
    
    guard let baseFont = UIFont(name: name, size: fontDescriptor.pointSize) else {
      // In case this happens, check that fonts are added correctly:
      // https://codewithchris.com/common-mistakes-with-adding-custom-fonts-to-your-ios-app/
      fatalError("Failed to create font `\(name)`.")
    }
    
    return fontMetrics.scaledFont(for: baseFont)
  }
}

extension Font {
  /// Creates a dynamic (accessible) system font based on TextStyle and Weight.
  static func dynamicSystemFont(with style: UIFont.TextStyle, weight: UIFont.Weight) -> Font {
    Font.system(style.swiftUIStyle).weight(weight.swiftUIWeight)
  }
  
  /// Creates a dynamic (accessible) custom font based on TextStyle and font name (which defines the weight).
  static func dynamicFont(with style: UIFont.TextStyle, name: String) -> Font {
    let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
    return .custom(name, size: fontDescriptor.pointSize, relativeTo: style.swiftUIStyle)
  }
}

private extension UIFont.TextStyle {
  /// Converts the `UIKit.UIFont.TextStyle` to `SwiftUI.Font.TextStyle`.
  var swiftUIStyle: Font.TextStyle {
    switch self {
    case .largeTitle: return .largeTitle
    case .title1: return .title
    case .title2: return .title2
    case .title3: return .title3
    case .headline: return .headline
    case .subheadline: return .subheadline
    case .callout: return .callout
    case .footnote: return .footnote
    case .caption1: return .caption
    case .caption2: return .caption2
    default: return .body
    }
  }
}

private extension UIFont.Weight {
  /// Converts the `UIKit.UIFont.Weight` to `SwiftUI.Font.Weight`.
  var swiftUIWeight: Font.Weight {
    switch self {
    case .ultraLight: return .ultraLight
    case .thin: return .thin
    case .light: return .light
    case .medium: return .medium
    case .semibold: return .semibold
    case .bold: return .bold
    case .heavy: return .heavy
    case .black: return .black
    default: return .regular
    }
  }
}
