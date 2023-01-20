import PlatformKit
import SwiftUI

/// This protocol provides a mechanism for defining custom font weights.
///
/// To use custom fonts, the project must include your desired `.otf`/`.ttf` files, one for each font/weight pair.
///
/// To define a custom font, you have to create a type conforming to `FontProtocol` with a subtype conforming
/// to `CustomFontWeight`. `CustomFontWeight` is used to define the available weights. It is recommended to create
/// those as `static let` properties. An instance of a `CustomFontWeight` must be able to format
/// a `fontWeightName: String` to match your `.otf`/`.ttf` file in your project.
///
/// Custom font example:
/// ```
/// struct CustomFont: FontProtocol {
///   struct Weight: CustomFontWeight {
///     let weight: String
///     var fontWeightName: String { "MyCustomFont-\(weight)" } // E.g. matches "MyCustomFont-Regular.ttf"/etc.
///
///     static let regular: Weight = .init("Regular")
///     static let bold: Weight = .init("Bold")
///
///     private init(_ weight: String) {
///       self.weight = weight
///     }
///   }
///
///   var textStyle: TextStyle
///   var weight: Weight
/// }
/// ```
public protocol CustomFontWeight {
  /// Name of the weight.
  var weight: String { get }
  /// Full name of the font + weight, matching the respective .otf/.ttf file.
  var fontWeightName: String { get }
}

public extension FontProtocol where WeightType: CustomFontWeight {
  /// Returns the custom SwiftUI Font for the specified style and weight.
  var font: Font {
    let name = weight.fontWeightName
    return .custom(name, size: pointSize, relativeTo: textStyle)
  }
  
  /// Returns the platform (UIFont/NSFont) custom font for the specified style and weight.
  var platformFont: PlatformFont {
#if canImport(UIKit)
    let baseFont = UIFont(name: weight.fontWeightName, size: pointSize)!
    return UIFontMetrics(forTextStyle: textStyle.platform).scaledFont(for: baseFont)
#else
    return .init(name: weight.fontWeightName, size: pointSize)!
#endif
  }
}
