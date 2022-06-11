import Foundation

public extension Collection where Element: Identifiable {
  func first(with id: Element.ID) -> Element? {
    self.first(where: { $0.id == id })
  }
  
  func firstIndex(with id: Element.ID) -> Index? {
    self.firstIndex(where: { $0.id == id })
  }
}

public extension RandomAccessCollection where Element: Identifiable {
  func last(with id: Element.ID) -> Element? {
    last(where: { $0.id == id })
  }
  
  func lastIndex(with id: Element.ID) -> Index? {
    lastIndex(where: { $0.id == id })
  }
}


public extension RangeReplaceableCollection where Element: Identifiable {
  mutating func removeAll(with id: Element.ID) {
    removeAll(where: { $0.id == id })
  }
}
