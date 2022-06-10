public extension Comparable {
  func clamped(_ lowerBound: Self, to upperBound: Self) -> Self {
    return min(max(self, lowerBound), upperBound)
  }
}
