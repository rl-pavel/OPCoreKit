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
  static func reduce(value currentValue: inout CGSize, nextValue: () -> CGSize) {
    _ = nextValue()
  }
}


// MARK: - Preview

#if DEBUG
struct SizeReader_Previews: PreviewProvider {
  struct Preview: View {
    @State var text: String = ""
    @State var textSize: CGSize = .zero
    
    var body: some View {
      VStack {
        TextField("type", text: $text)
          .fixedSize()
          .readSize(into: $textSize)
          .background(Color.black.opacity(0.05))
        Text("Size: w\(Int(textSize.width)) h\(Int(textSize.height))")
      }
    }
  }
  
  static var previews: some View {
    Preview().padding()
  }
}
#endif
