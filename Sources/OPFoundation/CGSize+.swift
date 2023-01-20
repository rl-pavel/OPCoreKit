import CoreGraphics

public extension CGSize {
    /// Creates a `CGSize` with the equal width and height.
    init(_ square: CGFloat) {
        self.init(width: square, height: square)
    }

    /// A `CGSize` with `.infinity` width and height. Useful for SwiftUI `frame` modifiers.
    static let infinity: CGSize = .init(CGFloat.infinity)
}

/// These extensions allow `CGSize` to be expressible by integer literals
/// to more easily create square sizes.
///
/// Example: `Color.red.frame(size: 50)`
extension CGSize: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        let size = CGFloat(value)
        self.init(size)
    }
}

/// This extension adds `Numeric` and math functionality to `CGSize`.
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
