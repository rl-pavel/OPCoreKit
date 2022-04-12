import OPFoundation
import SwiftUI

public enum TypeStyle {
  case largeTitle, title1, title2, title3, headline, body, callout, subheadline, footnote, caption1, caption2
  
  var universalStyle: Font.TextStyle {
    switch self {
    case .largeTitle: return .largeTitle
    case .title1: return .title
    case .title2: return .title2
    case .title3: return .title3
    case .headline: return .headline
    case .body: return .body
    case .callout: return .callout
    case .subheadline: return .subheadline
    case .footnote: return .footnote
    case .caption1: return .caption
    case .caption2: return .caption2
    }
  }
}


/// A protocol that defines a font, which can be used to create Dynamic Type text styles.
///
/// Custom fonts can be defined by creating a subtype conforming to`CustomFontWeight`.
public protocol FontType {
  associatedtype WeightType
  var style: TypeStyle { get }
  var weight: WeightType { get }
  
  init(style: TypeStyle, weight: WeightType)
  
  var font: Font { get }
  var platformFont: PlatformFont { get }
}

/// A helper protocol for custom fonts, which provides default implementations for FontType fields.
///
/// Custom Font Example:
/// ```
/// struct SomeFont: FontType {
///   struct Weight: CustomFontWeight {
///     let weight: String
///     var fontWeightName: String { "SomeFont-\(weight)" }
///
///     static let regular = Weight("Regular")
///
///     private init(_ weightName: String) {
///       self.weight = weightName
///     }
///   }
///
///   var style: UIFont.TextStyle
///   var weight: Weight
/// }
/// ```
public protocol CustomFontWeight {
  /// Name of the weight.
  var weight: String { get }
  /// Full name of the font + weight, matching the respective .otf/.ttf file.
  var fontWeightName: String { get }
  
  static var regular: Self { get }
}


// MARK: - System Font

public extension FontType where WeightType == Font.Weight {
  var font: Font {
    .system(style.universalStyle).weight(weight)
  }
  
  var platformFont: PlatformFont {
#if canImport(UIKit)
    let baseFont = UIFont.systemFont(ofSize: pointSize, weight: weight.platform)
    return UIFontMetrics(forTextStyle: style.platform).scaledFont(for: baseFont)
#else
    PlatformFont.systemFont(ofSize: pointSize, weight: weight.platform)
#endif
  }
}


// MARK: - Custom Font

public extension FontType where WeightType: CustomFontWeight {
  var font: Font {
    let name = weight.fontWeightName
    return .custom(name, size: pointSize, relativeTo: style.universalStyle)
  }
  
  var platformFont: PlatformFont {
#if canImport(UIKit)
    let baseFont = UIFont(name: weight.fontWeightName, size: pointSize)!
    return UIFontMetrics(forTextStyle: style.platform).scaledFont(for: baseFont)
#else
    .init(name: weight.fontWeightName, size: pointSize)!
#endif
  }
}


// MARK: - Helpers

private extension FontType {
  private var pointSize: CGFloat {
#if canImport(UIKit)
    UIFontDescriptor.preferredFontDescriptor(withTextStyle: style.platform)
      .pointSize
#elseif canImport(AppKit)
    NSFontDescriptor.preferredFontDescriptor(forTextStyle: style.platform, options: [:])
      .pointSize
#else
    fatalError("Not Implemented")
#endif
  }
}

private extension TypeStyle {
#if canImport(UIKit)
  typealias PlatformStyle = UIFont.TextStyle
#elseif canImport(AppKit)
  typealias PlatformStyle = NSFont.TextStyle
#endif
  
  var platform: PlatformStyle {
    switch self {
    case .largeTitle: return .largeTitle
    case .title1: return .title1
    case .title2: return .title2
    case .title3: return .title3
    case .headline: return .headline
    case .body: return .body
    case .callout: return .callout
    case .subheadline: return .subheadline
    case .footnote: return .footnote
    case .caption1: return .caption1
    case .caption2: return .caption2
    }
  }
}

private extension Font.Weight {
#if canImport(UIKit)
  typealias PlatformWeight = UIFont.Weight
#elseif canImport(AppKit)
  typealias PlatformWeight = NSFont.Weight
#endif
  
  var platform: PlatformWeight {
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
