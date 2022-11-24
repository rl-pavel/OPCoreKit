import OPFoundation
import SwiftUI

public extension View {
  func visible(on platforms: Platform) -> some View {
    return modifier(PlatformVisibility(platforms))
  }
}

private struct PlatformVisibility: ViewModifier {
  private var platforms: Platform = .current
  
  init(_ platforms: Platform) {
    self.platforms = platforms
  }
  
  func body(content: Content) -> some View {
    platforms.contains(.current) ? content : nil
  }
}
