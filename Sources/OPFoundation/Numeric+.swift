public extension BinaryFloatingPoint {
  /// Interpolates the value between 0...1 in a specified range.
  /// - Parameters:
  ///   - isDescending: Whether to interpolate down from 1>0, or up from 0>1 .
  ///   - range: The range when the interpolation should start and finish.
  /// - Returns: The interpolated 0...1 value.
  ///
  /// Examples:
  /// ```
  /// 0.interpolate(from: false, between: 50...100)   // 0
  /// 0.interpolate(from: true, between: 50...100)    // 1
  ///
  /// 70.interpolate(from: false, between: 50...100)  // 0.4
  /// 70.interpolate(from: true, between: 50...100)   // 0.6
  ///
  /// 150.interpolate(from: false, between: 50...100) // 1
  /// 150.interpolate(from: true, between: 50...100)  // 0
  /// ```
  func interpolate(from isDescending: Bool, between range: ClosedRange<Self>) -> Self {
    let maxDifference = range.upperBound - range.lowerBound
    let difference = (range.upperBound - self).clamped(0, to: range.lowerBound)
    return isDescending ? difference / maxDifference : 1 - (difference / maxDifference)
  }
}
