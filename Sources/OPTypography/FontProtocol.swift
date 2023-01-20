import PlatformKit
import SwiftUI

/// `FontProtocol` defines an instance of a font using `TextStyle` and `WeightType` that supports Dynamic Type.
///
/// To use custom fonts, the project must include your desired `.otf`/`.ttf` files, one for each font/weight pair.
///
/// To define a custom font, you have to create a type conforming to `FontProtocol` with a subtype conforming
/// to `CustomFontWeight`, which maps to the `.otf`/`.ttf` files in your project.
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
public protocol FontProtocol {
  typealias TextStyle = SwiftUI.Font.TextStyle
  associatedtype WeightType
  
  var textStyle: TextStyle { get }
  var weight: WeightType { get }
  
  init(style: Font.TextStyle, weight: WeightType)
  
  var font: Font { get }
  var platformFont: PlatformFont { get }
}

public extension FontProtocol {
  /// Returns the font point size for the selected platform.
  var pointSize: CGFloat {
#if canImport(UIKit)
    UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle.platform).pointSize
#elseif canImport(AppKit)
    NSFontDescriptor.preferredFontDescriptor(forTextStyle: textStyle.platform, options: [:]).pointSize
#else
    fatalError("FontProtocol.pointSize is not implemented for this platform.")
#endif
  }
}
