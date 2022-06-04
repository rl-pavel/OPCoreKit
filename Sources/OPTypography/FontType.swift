import OPFoundation
import SwiftUI

/// A protocol that defines a font, which can be used to create weighted Dynamic Type text styles.
///
/// See `CustomFontWeight` for defining custom fonts.
public protocol FontType {
  associatedtype WeightType
  var style: TypeStyle { get }
  var weight: WeightType { get }
  
  init(style: TypeStyle, weight: WeightType)
  
  var font: Font { get }
  var platformFont: PlatformFont { get }
}

/// A protocol allowing for creation of custom font types. The project must include the font .otf/.ttf files.
/// The struct conforming to `CustomFontWeight` formats the font name + a given weight to match those files.
/// It's recommended to define the weights as `static let` properties to cover the available font options.
///
/// Custom Font Example:
/// ```
/// struct CustomFont: FontType {
///   struct Weight: CustomFontWeight {
///     let weight: String
///     var fontWeightName: String { "CustomFont-\(weight)" }
///
///     static let regular: Weight = .init("Regular")
///     static let bold: Weight = .init("Bold")
///
///     private init(_ weight: String) {
///       self.weight = weight
///     }
///   }
///
///   var style: TypeStyle
///   var weight: Weight
/// }
/// ```
public protocol CustomFontWeight {
  /// Name of the weight.
  var weight: String { get }
  /// Full name of the font + weight, matching the respective .otf/.ttf file.
  var fontWeightName: String { get }
}
