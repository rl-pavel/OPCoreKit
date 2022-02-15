import Foundation
import CoreGraphics

public extension Numeric {
  static var x2: Self { 2 }
  static var x4: Self { 4 }
  static var x6: Self { 6 }
  static var x8: Self { 8 }
  static var x10: Self { 10 }
  static var x12: Self { 12 }
  static var x16: Self { 16 }
  static var x20: Self { 20 }
  static var x24: Self { 24 }
  static var x28: Self { 28 }
  static var x32: Self { 32 }
  static var x36: Self { 36 }
  static var x40: Self { 40 }
}

#if canImport(UIKit)
import UIKit

public extension Numeric {
  static var pixel: CGFloat { 1.0 / UIScreen.main.scale }
}

#elseif canImport(AppKit)
import AppKit

public extension Numeric {
  static var pixel: CGFloat { NSScreen.main.map { 1.0 / $0.backingScaleFactor } ?? 1 }
}
#endif
