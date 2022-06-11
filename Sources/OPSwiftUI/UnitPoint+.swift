import SwiftUI

public extension UnitPoint {
  static func x(_ value: CGFloat) -> UnitPoint {
    .init(x: value, y: 0.5)
  }
  
  static func y(_ value: CGFloat) -> UnitPoint {
    .init(x: 0.5, y: value)
  }
  
  func x(_ value: CGFloat) -> UnitPoint {
    .init(x: value, y: y)
  }
  
  func y(_ value: CGFloat) -> UnitPoint {
    .init(x: x, y: value)
  }
}
