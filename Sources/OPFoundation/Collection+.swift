import Foundation

public extension Collection {
  var isNotEmpty: Bool { !isEmpty }
  
  /// Returns `nil` if the collection is empty.
  var nonEmpty: Self? {
    guard !isEmpty else { return nil }
    return self
  }
  
  
  func count(where body: (Element) throws -> Bool) rethrows -> Int {
    return try filter(body).count
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
  
  /// Perform a side effect, passing through the contents.
  @discardableResult
  func perform(_ body: (Self) throws -> ()) rethrows -> Self {
    try body(self)
    return self
  }
}


public extension Collection where Element: OptionalType {
  func compact() -> [Element.Wrapped] {
    compactMap { $0.optional }
  }
}

public extension Collection where Element: Collection {
  func flatten() -> [Element.Element] {
    flatMap { $0 }
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
