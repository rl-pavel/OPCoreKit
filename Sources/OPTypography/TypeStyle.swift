import SwiftUI

/// A text style enum bridge between `Font.TextStyle`, `UIFont.TextStyle` and `NSFont.TextStyle`.
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

extension TypeStyle {
#if canImport(UIKit)
  typealias PlatformStyle = UIFont.TextStyle
#elseif canImport(AppKit)
  typealias PlatformStyle = NSFont.TextStyle
#endif
  
  /// Converts the style to a platform `(UIFont/NSFont).TextStyle`.
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
