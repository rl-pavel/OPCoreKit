import UIKit

public extension CGSize {
  init(_ size: CGFloat) {
    self.init(width: size, height: size)
  }
  
  static let infinity: CGSize = .init(CGFloat.infinity)
}

extension CGSize: ExpressibleByIntegerLiteral {
  public init(integerLiteral value: Int) {
    let size = CGFloat(value)
    self.init(size)
  }
}

// This conformance makes it possible to use the Numeric spacing extensions, like .x16.
extension CGSize: Numeric {
  public var magnitude: CGFloat {
    fatalError("Magnitude cannot be used on CGSize.")
  }
  
  public init?<T: BinaryInteger>(exactly source: T) {
    self.init(CGFloat(source))
  }
  
  public static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
    CGSize(
      width: lhs.width + rhs.width,
      height: lhs.height + rhs.height
    )
  }
  
  public static func - (lhs: CGSize, rhs: CGSize) -> CGSize {
    CGSize(
      width: lhs.width - rhs.width,
      height: lhs.height - rhs.height
    )
  }
  
  public static func * (lhs: CGSize, rhs: CGSize) -> CGSize {
    CGSize(
      width: lhs.width * rhs.width,
      height: lhs.height * rhs.height
    )
  }
  
  public static func *= (lhs: inout CGSize, rhs: CGSize) {
    lhs.width *= rhs.width
    lhs.height *= rhs.height
  }
}
