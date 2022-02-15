import SwiftUI

public struct SystemFont: FontType {
  public var style: TypeStyle
  public var weight: Font.Weight
  
  public init(style: TypeStyle, weight: Font.Weight) {
    self.style = style
    self.weight = weight
  }
}

struct CircularFont: FontType {
  struct Weight: CustomFontWeight {
    let weight: String
    var fontWeightName: String { "CircularXX-\(weight)" }
    
    static let regular = Weight("Regular")
    static let book = Weight("Book")
    static let medium = Weight("Medium")
    static let bold = Weight("Bold")
    static let black = Weight("Black")
    
    private init(_ weightName: String) {
      self.weight = weightName
    }
  }
  
  var style: TypeStyle
  var weight: Weight
  
//  var uiFont: UIFont { dynamicUIFont(with: style, name: weight.fontName) }
//  var font: Font { dynamicFont(with: style, name: weight.fontName) }
  
//  static func staticFont(size: CGFloat, weight: Weight = .regular) -> Font {
//    .custom(weight.fontName, size: size)
//  }
//
//  static func staticUIFont(size: CGFloat, weight: Weight = .regular) -> UIFont {
//    .init(name: weight.fontName, size: size)!
//  }
}
