import OPFoundation
import SwiftUI

public extension View {
  func readSize(into size: Binding<CGSize>) -> some View {
    self.modifier(SizeReader(size: size))
  }
  
  func readSize(changed: @escaping Closure<CGSize>) -> some View {
    self.modifier(SizeReader(size: .init(get: { .zero }, set: changed)))
  }
}

private struct SizeReader: ViewModifier {
  @Binding var size: CGSize
  
  func body(content: Content) -> some View {
    content
      .background(
        GeometryReader { proxy in
          Color.clear
            .preference(key: SizePreferenceKey.self, value: proxy.size)
        }
      )
      .onPreferenceChange(SizePreferenceKey.self) { size = $0 }
  }
}

private struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value currentValue: inout CGSize, nextValue: Factory<CGSize>) {
    _ = nextValue()
  }
}
