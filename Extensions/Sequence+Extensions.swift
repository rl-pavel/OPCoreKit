import Foundation

public extension Sequence {
  func count(where body: (Element) throws -> Bool) rethrows -> Int {
    return try filter(body).count
  }
  
  func compactFlatMap<S: Sequence>(_ transform: (Element) throws -> S?) rethrows -> [S.Element] {
    try compactMap(transform).flatMap { $0 }
  }
  
  /// Lazily returns the first element that can be transformed/mapped to a different type, as that type.
  func mapFirst<T>(_ transform: (Element) throws -> T?) rethrows -> T? {
    return try lazy.compactMap(transform).first
  }
  
  /// Perform a side effect for each element in `self`.
  @discardableResult
  func forEachPerform(_ body: (Element) throws -> ()) rethrows -> Self {
    try forEach(body)
    return self
  }
  
  /// Perform a side effect.
  @discardableResult
  func perform(_ body: (Self) throws -> ()) rethrows -> Self {
    try body(self)
    return self
  }
}

public extension Sequence where Element: OptionalType {
  func compact() -> [Element.Wrapped] {
    compactMap { $0.optional }
  }
}

public extension Sequence where Element: Sequence {
  func flatten() -> [Element.Element] {
    flatMap { $0 }
  }
}

public extension Collection {
  /// Returns `nil` if the collection is empty.
  var nonEmpty: Self? {
    guard !isEmpty else { return nil }
    return self
  }
  
  var isNotEmpty: Bool {
    return !isEmpty
  }
}

public extension Array {
  func makePairs(of pairCount: Int) -> [[Element]] {
    guard pairCount > 1 && pairCount < self.count else { return [self] }
    
    return indices.dropLast(pairCount - 1).map { idx in
      (idx..<index(idx, offsetBy: pairCount)).map { self[$0] }
    }
  }
  
  func forEachPair(of pairCount: Int, perform: ([Element]) throws -> Void) rethrows {
    try makePairs(of: pairCount).forEach(perform)
  }
}


public extension RandomAccessCollection {
  /// Returns the element at specified index if it's within bounds, otherwise nil.
  subscript(safe index: Index) -> Element? {
    guard index >= startIndex, index < endIndex else {
      return nil
    }
    return self[index]
  }
}


public extension RangeReplaceableCollection {
  func appending(contentsOf other: Self) -> Self {
    var copy = self
    copy.append(contentsOf: other)
    return copy
  }
  
  func appending(_ element: Element) -> Self {
    var copy = self
    copy.append(element)
    return copy
  }
}

public extension Array {
  mutating func prepend(_ element: Element) {
    insert(element, at: startIndex)
  }
  
  func prepending(_ element: Element) -> Self {
    var copy = self
    copy.insert(element, at: startIndex)
    return copy
  }
  
  func prepending(contentsOf elements: Self) -> Self {
    var copy = self
    copy.insert(contentsOf: elements, at: startIndex)
    return copy
  }
}
