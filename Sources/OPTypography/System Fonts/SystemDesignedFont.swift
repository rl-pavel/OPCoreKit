import PlatformKit
import SwiftUI

@available(iOS 16.0, *)
@available(macOS 13.0, *)
public protocol SystemDesignedFont: FontProtocol where WeightType == Font.Weight {
  var design: Font.Design { get }
}

@available(iOS 16.0, *)
@available(macOS 13.0, *)
public extension SystemDesignedFont {
  var font: Font {
    .system(textStyle, design: design, weight: weight)
  }
  
  var platformFont: PlatformFont {
#if canImport(UIKit)
    let baseFont = UIFont.systemFont(ofSize: pointSize, weight: weight.platform)
    let roundedFont = baseFont.fontDescriptor.withDesign(design.platform)
      .map { UIFont(descriptor: $0, size: pointSize) } ?? baseFont
    return UIFontMetrics(forTextStyle: textStyle.platform).scaledFont(for: roundedFont)
#else
    let baseFont = NSFont.systemFont(ofSize: pointSize, weight: weight.platform)
    return baseFont.fontDescriptor.withDesign(design.platform)
      .flatMap { NSFont(descriptor: $0, size: pointSize) } ?? baseFont
#endif
  }
}
