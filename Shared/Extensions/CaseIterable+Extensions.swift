import Foundation

public extension CaseIterable
where Self: Equatable,
      Self: RawRepresentable,
      RawValue == String,
      AllCases.Index == Int {
  init?(intValue: Int) {
    guard intValue <= Self.allCases.endIndex && intValue >= Self.allCases.startIndex else { return nil }
    self = Self.allCases[intValue]
  }
  
  var intValue: Int {
    return Self.allCases.firstIndex(of: self)!
  }
}

public extension Comparable {
  /// Clamps the value between the specified lower and upper bound.
  /// Requires a valid Range, where `lowerBound < upperBound`.
  func clamped(to limits: ClosedRange<Self>) -> Self {
    return min(max(self, limits.lowerBound), limits.upperBound)
  }
}
