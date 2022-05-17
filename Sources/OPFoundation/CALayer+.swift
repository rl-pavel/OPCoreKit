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
  
  @discardableResult
  func transition(
    _ type: CATransitionType,
    away subtype: CATransitionSubtype?,
    for duration: TimeInterval = 0.3,
    timingFunction: CAMediaTimingFunctionName = .easeInEaseOut,
    forKey key: String = "transition",
    completion: VoidClosure? = nil) -> CATransition {
      let transition = CATransition()
      transition.duration = duration
      transition.type = type
      transition.subtype = subtype
      transition.timingFunction = CAMediaTimingFunction(name: timingFunction)
      
      add(transition, forKey: key)
      DispatchQueue.main.asyncAfter(deadline: .now() + duration) { completion?() }
      
      return transition
    }
}
