import SwiftUI

public extension AnyTransition {
  static func fade(from edge: Edge) -> AnyTransition {
    return .move(edge: edge).combined(with: .opacity)
  }
}
