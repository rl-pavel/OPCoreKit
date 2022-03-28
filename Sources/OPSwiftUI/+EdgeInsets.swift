import SwiftUI

public extension EdgeInsets {
  init(edges: CGFloat) {
    self = .init(top: edges, leading: edges, bottom: edges, trailing: edges)
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
  
  static var zero: EdgeInsets { .init(edges: 0) }
}
