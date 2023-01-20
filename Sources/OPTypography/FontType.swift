import OPFoundation
import SwiftUI
import PlatformKit

/// Defines a font any `FontProtocol` type with additional `lineSpacing` and `tracking` options.
///
/// This struct is intended to be use as a collection of fonts you need in your project.
///
/// There are already presets matching the native `TextStyle`s, using `SystemFont`, `SystemFontRounded`,
/// `SystemMonospacedFont` and `SystemSerifFont`. However you can create your own variations of those,
/// for example `systemBodyBold`, or define a custom `FontType` if you are using a custom font.
///
/// There are helpful extensions for many text components, from `SwiftUI.Text`, to `UIKit.UITextView` and even
/// `NS(Mutable)AttributedString`. `AppKit` extensions are also coming soon, there is already one for `NSTextView`.
///
/// All the extensions that that use the `FontType` share the same naming convention of `applyStyle(...)`,
/// and also provide a quick way to apply other common styling, such as color, alignment, and more.
///
/// Here's how easy it is to add a font, which can be used for any text in your project:
/// ```
/// extension FontType {
///   static var systemBodyBold: FontType<SystemFont> {
///     .init(style: .body, weight: .bold)
///   }
///
///   static var systemWideHeavyHeadline: FontType<SystemFont> {
///     .init(style: .headline, weight: .heavy, lineSpacing: 2, tracking: 2)
///   }
/// 
///   static var myBodyFontThicc: FontType<MyCustomFont> {
///     .init(style: .body, weight: .thicc)
///   }
/// }
/// ```
public struct FontType<Font: FontProtocol> {
  private let internalFont: Font
  
  public var font: SwiftUI.Font { internalFont.font }
  public var platformFont: PlatformFont { internalFont.platformFont }
  
  public var lineSpacing: CGFloat
  public var tracking: CGFloat
  
  public init(style: Font.TextStyle, weight: Font.WeightType, lineSpacing: CGFloat = 0, tracking: CGFloat = 0) {
    self.internalFont = .init(style: style, weight: weight)
    self.lineSpacing = lineSpacing
    self.tracking = tracking
  }
}
