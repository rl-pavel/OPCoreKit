import Foundation

public extension NSError {
  convenience init(_ description: String, withCode code: Int = -1) {
    let bundleInfo = Bundle.main.infoDictionary
    let bundleDisplayName = bundleInfo?[kCFBundleNameKey as String] as? String ?? ""
    self.init(domain: bundleDisplayName, code: code, userInfo: [NSLocalizedDescriptionKey: description])
  }
}

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
