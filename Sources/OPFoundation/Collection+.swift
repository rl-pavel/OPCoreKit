import Foundation

public extension Collection {
  var isNotEmpty: Bool { !isEmpty }
  
  /// Returns `nil` if the collection is empty.
  var nonEmpty: Self? {
    guard !isEmpty else { return nil }
    return self
  }
  
  /// Returns the number of elements of the sequence that satisfy the given predicate.
  func count(where body: (Element) throws -> Bool) rethrows -> Int {
    return try filter(body).count
  }
  
  /// Lazily returns the first element that can be mapped to a different type, as that type.
  ///
  /// `let someView = view.subviews.mapFirst { $0 as? SomeView }`
  func mapFirst<T>(_ transform: (Element) throws -> T?) rethrows -> T? {
    return try lazy.compactMap(transform).first
  }
  
  /// Performs a side effect for each element in `self`. Usable in chained Sequence operations.
  ///
  /// Source: https://oleb.net/blog/2017/10/chained-foreach/
  ///
  /// ```
  /// [1, 2, 3]
  ///   .forEachPerform { print("Initial: \($0)") }
  ///   .map { $0 * $0 }
  ///   .forEach { print("Square: \($0)\n") }
  /// ```
  @discardableResult
  func forEachPerform(_ body: (Element) throws -> ()) rethrows -> Self {
    try forEach(body)
    return self
  }
  
  /// Perform a single side effect, passing through the contents.
  @discardableResult
  func perform(_ body: (Self) throws -> ()) rethrows -> Self {
    try body(self)
    return self
  }
  
  
  // Conditionals
  
  /// Returns an array containing the non-`nil` elements.
  func compact() -> [Element.Wrapped] where Element: OptionalType {
    compactMap { $0.optional }
  }
  
  /// Flattens a nested collection into a single array.
  func flatten() -> [Element.Element] where Element: Collection {
    flatMap { $0 }
  }
  
  func first(with id: Element.ID) -> Element? where Element: Identifiable {
    self.first(where: { $0.id == id })
  }
  
  func firstIndex(with id: Element.ID) -> Index? where Element: Identifiable {
    self.firstIndex(where: { $0.id == id })
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
  
  func last(with id: Element.ID) -> Element? where Element: Identifiable {
    self.last(where: { $0.id == id })
  }
  
  func lastIndex(with id: Element.ID) -> Index? where Element: Identifiable {
    self.lastIndex(where: { $0.id == id })
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
  
  mutating func removeAll(with id: Element.ID) where Element: Identifiable {
    self.removeAll(where: { $0.id == id })
  }
}
