#if canImport(UIKit)
import UIKit

public extension UIScreen {
  static var size: CGSize { main.bounds.size }
  static var width: CGFloat { size.width }
  static var height: CGFloat { size.height }
}
#endif
