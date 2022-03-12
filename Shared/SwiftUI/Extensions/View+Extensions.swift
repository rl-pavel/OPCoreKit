import SwiftUI

public extension View {
  @ViewBuilder
  func `if`<Content: View>(
    _ condition: @autoclosure () -> Bool,
    transform: (Self) -> Content) -> some View {
      if condition() {
        transform(self)
      } else {
        self
      }
    }
  
  @ViewBuilder
  func ifLet<Value, IfLetContent: View>(
    _ condition: @autoclosure () -> Value?,
    transform: (Self, Value) -> IfLetContent) -> some View {
      if let value = condition() {
        transform(self, value)
      } else {
        self
      }
    }
  
  @ViewBuilder
  func `if`<IfContent: View, ElseContent: View>(
    _ condition: @autoclosure () -> Bool,
    transform: (Self) -> IfContent,
    else elseTransform: (Self) -> ElseContent) -> some View {
      if condition() {
        transform(self)
      } else {
        elseTransform(self)
      }
    }
  
  func frame(size: CGSize?, alignment: Alignment = .center) -> some View {
    return self.frame(width: size?.width, height: size?.height, alignment: alignment)
  }
  
  func frame(
    minSize: CGSize? = nil,
    idealSize: CGSize? = nil,
    maxSize: CGSize? = nil,
    alignment: Alignment = .center) -> some View {
      return self.frame(
        minWidth: minSize?.width,
        idealWidth: idealSize?.width,
        maxWidth: maxSize?.width,
        minHeight: minSize?.height,
        idealHeight: idealSize?.height,
        maxHeight: maxSize?.height,
        alignment: alignment)
    }
  
  func overlayMask<Content: View>(_ content: Content) -> some View {
    self.overlay(content.mask(self))
  }
  
  func placeholder<Content: View>(
    when shouldShowPlaceholder: Bool,
    alignment: Alignment = .leading,
    @ViewBuilder placeholder: () -> Content) -> some View {
      ZStack(alignment: alignment) {
        if shouldShowPlaceholder {
          placeholder()
            .transition(.opacity.animation(.linear(duration: 0.1)))
        }
        self
      }
    }
  
  /// Combines offset with padding to move the view from one of the edges by a certain length.
  func move(_ edge: Edge, by length: CGFloat) -> some View {
    let isHorizontal = edge == .leading || edge == .trailing
    
    return self
      .offset(x: isHorizontal ? length : 0, y: !isHorizontal ? length : 0)
      .padding(.init(edge), -abs(length))
  }
  
#if DEBUG
  /// Adds a colored overlay showing the size of the view for debugging purposes.
  func debugSizeOverlay(color: Color = .red) -> some View {
    self.overlay(
      GeometryReader { frame in
        color.opacity(0.15)
          .overlay(
            Text("w\(Int(frame.size.width)) h\(Int(frame.size.height))")
              .opacity(0.8)
              .font(.title)
              .foregroundColor(.red)
              .minimumScaleFactor(0.1)
              .shadow(color: .black, radius: 1)
              .shadow(color: .black, radius: 1)
              .shadow(color: .black, radius: 1)
          )
          .frame(size: frame.size)
      }
        .allowsHitTesting(false)
    )
  }
#endif
}
