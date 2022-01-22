import UIKit
import SwiftUI

public struct SystemFont: FontType {
  public var style: UIFont.TextStyle
  public var weight: UIFont.Weight
  
  public var uiFont: UIFont { .dynamicSystemUIFont(with: style, weight: weight) }
  public var font: Font { .dynamicSystemFont(with: style, weight: weight) }
  
  public init(style: UIFont.TextStyle, weight: UIFont.Weight) {
    self.style = style
    self.weight = weight
  }
}
