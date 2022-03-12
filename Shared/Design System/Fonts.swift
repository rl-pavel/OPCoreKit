import SwiftUI

public struct SystemFont: FontType {
  public var style: TypeStyle
  public var weight: Font.Weight
  
  public init(style: TypeStyle, weight: Font.Weight) {
    self.style = style
    self.weight = weight
  }
}
