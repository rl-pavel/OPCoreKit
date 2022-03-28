/// Allows creation of SwiftUI-style arrays using a closure. Watch this
/// [WWDC session](https://developer.apple.com/videos/play/wwdc2021/10253/) showing how this works.
///
/// `init(@ArrayBuilder<Int> build: Factory<Int>)`
/// ```
/// .init {
///   1
///   2
///   // Either `3` or `4`.
///   if Bool.random() {
///     3
///   } else {
///     4
///   }
///   Optional<Int>.none // nil.
///   Optional<Int>.some(5) // unwrapped `5`.
/// }
/// ```
@resultBuilder
enum ArrayBuilder<Element> {
  typealias Expression = Element
  typealias Component = [Element]
  
  static func buildExpression(_ expression: Expression) -> Component {
    [expression]
  }
  
  static func buildExpression(_ expression: Expression?) -> Component {
    expression.map { [$0] } ?? []
  }
  
  static func buildBlock(_ children: Component...) -> Component {
    children.flatMap { $0 }
  }
  
  static func buildOptional(_ children: Component?) -> Component {
    children ?? []
  }
  
  static func buildBlock(_ component: Component) -> Component {
    component
  }
  
  static func buildEither(first child: Component) -> Component {
    child
  }
  
  static func buildEither(second child: Component) -> Component {
    child
  }
}
