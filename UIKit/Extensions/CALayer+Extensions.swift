import QuartzCore

public extension CACornerMask {
  static var topLeft: CACornerMask { .layerMinXMinYCorner }
  static var topRight: CACornerMask { .layerMaxXMinYCorner }
  static var bottomLeft: CACornerMask { .layerMinXMaxYCorner }
  static var bottomRight: CACornerMask { .layerMaxXMaxYCorner }
  static var all: CACornerMask { [topLeft, topRight, bottomLeft, bottomRight] }
}

public extension CALayer {
  func roundCorners(
    _ corners: CACornerMask,
    radius: CGFloat,
    cornerCurve: CALayerCornerCurve = .continuous,
    borderWidth: CGFloat = 0,
    borderColor: PlatformColor = .clear) {
      cornerRadius = radius
      maskedCorners = corners
      self.cornerCurve = cornerCurve
      masksToBounds = true
      
      if borderWidth > 0 {
        self.borderWidth = borderWidth
        self.borderColor = borderColor.cgColor
      }
    }
}
