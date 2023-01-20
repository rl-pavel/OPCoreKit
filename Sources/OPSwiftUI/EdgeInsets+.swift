import SwiftUI

public extension EdgeInsets {
  init(all: CGFloat) {
    self = .init(top: all, leading: all, bottom: all, trailing: all)
  }
  
  init(vertical: CGFloat = 0, horizontal: CGFloat = 0) {
    self = .init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
  }
  
  static func inset(
    top: CGFloat = 0,
    leading: CGFloat = 0,
    bottom: CGFloat = 0,
    trailing: CGFloat = 0) -> EdgeInsets {
      return .init(top: top, leading: leading, bottom: bottom, trailing: trailing)
    }
  
  static func + (lhs: EdgeInsets, rhs: EdgeInsets) -> EdgeInsets {
    var resultInsets = lhs
    resultInsets.top += rhs.top
    resultInsets.leading += rhs.leading
    resultInsets.trailing += rhs.trailing
    resultInsets.bottom += rhs.bottom
    return resultInsets
  }
  
  static let zero: EdgeInsets = .init(all: 0)
}
