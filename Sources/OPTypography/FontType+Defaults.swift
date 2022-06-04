import OPFoundation
import SwiftUI

// MARK: - System Font

public extension FontType where WeightType == Font.Weight {
  /// Returns the system SwiftUI Font for the specified style and weight.
  var font: Font {
    .system(style.universalStyle).weight(weight)
  }
  
  /// Returns the platform (UIFont/NSFont) system font for the specified style and weight.
  var platformFont: PlatformFont {
#if canImport(UIKit)
    let baseFont = UIFont.systemFont(ofSize: pointSize, weight: weight.platform)
    return UIFontMetrics(forTextStyle: style.platform).scaledFont(for: baseFont)
#else
    NSFont.systemFont(ofSize: pointSize, weight: weight.platform)
#endif
  }
}

extension Font.Weight {
#if canImport(UIKit)
  typealias PlatformWeight = UIFont.Weight
#elseif canImport(AppKit)
  typealias PlatformWeight = NSFont.Weight
#endif
  
  /// Converts the universal `Font.Weight` to a platform `(UIFont/NSFont).Weight`.
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


// MARK: - Custom Font

public extension FontType where WeightType: CustomFontWeight {
  /// Returns the custom SwiftUI Font for the specified style and weight.
  var font: Font {
    let name = weight.fontWeightName
    return .custom(name, size: pointSize, relativeTo: style.universalStyle)
  }
  
  /// Returns the platform (UIFont/NSFont) custom font for the specified style and weight.
  var platformFont: PlatformFont {
#if canImport(UIKit)
    let baseFont = UIFont(name: weight.fontWeightName, size: pointSize)!
    return UIFontMetrics(forTextStyle: style.platform).scaledFont(for: baseFont)
#else
    return .init(name: weight.fontWeightName, size: pointSize)!
#endif
  }
}


// MARK: - Shared Helpers

extension FontType {
  /// Returns the font point size for the selected platform.
  var pointSize: CGFloat {
#if canImport(UIKit)
    UIFontDescriptor.preferredFontDescriptor(withTextStyle: style.platform).pointSize
#elseif canImport(AppKit)
    NSFontDescriptor.preferredFontDescriptor(forTextStyle: style.platform, options: [:]).pointSize
#else
    fatalError("FontType.pointSize is not implemented for this platform.")
#endif
  }
}
