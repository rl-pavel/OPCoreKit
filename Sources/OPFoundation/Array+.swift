import Foundation

// MARK: - Array

public extension Array {
  /// Creates pairs of arrays with a specified count of elements.
  ///
  /// Example:
  /// ```
  /// let array = [1, 2, 3, 4]
  /// array.makePairs(of: 2) // [[1, 2], [2, 3], [3, 4]]
  /// ```
  func makePairs(of pairCount: Int) -> [[Element]] {
    guard pairCount > 1 && pairCount < count else { return [self] }
    
    return indices.dropLast(pairCount - 1).map { idx in
      (idx..<index(idx, offsetBy: pairCount)).map { self[$0] }
    }
  }
  
  func forEachPair(of pairCount: Int, perform: ([Element]) throws -> Void) rethrows {
    try makePairs(of: pairCount).forEach(perform)
  }
}
