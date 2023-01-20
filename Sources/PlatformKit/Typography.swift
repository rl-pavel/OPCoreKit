import SwiftUI

public extension Font.Weight {
  /// Converts the universal `Font.Weight` to a platform `(UIFont/NSFont).Weight`.
  var platform: PlatformFontWeight {
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

public extension Font.TextStyle {
  /// Converts the universal `Font.TextStyle` to a platform `(UIFont/NSFont).TextStyle`
  var platform: PlatformTextStyle {
    switch self {
    case .largeTitle: return .largeTitle
    case .title: return .title1
    case .title2: return .title2
    case .title3: return .title3
    case .headline: return .headline
    case .body: return .body
    case .callout: return .callout
    case .subheadline: return .subheadline
    case .footnote: return .footnote
    case .caption: return .caption1
    case .caption2: return .caption2
    @unknown default:
      fatalError("Unknown text style: \(self).")
    }
  }
}

public extension Font.Design {
  /// Converts the universal `Font.Design` to a platform `(UIFont/NSFont)Descriptor.SystemDesign`
  var platform: PlatformFontDesign {
    switch self {
    case .serif: return .serif
    case .rounded: return .rounded
    case .monospaced: return .monospaced
    default:
      fatalError("Unknown design: \(self)")
    }
  }
}
