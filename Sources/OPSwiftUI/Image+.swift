import SwiftUI

public extension Image {
  var template: Image { renderingMode(.template) }
  var original: Image { renderingMode(.original) }
  
  static func symbol(_ systemName: String, size: CGFloat = 17, weight: Font.Weight = .regular) -> some View {
    Image(systemName: systemName)
      .font(.system(size: size, weight: weight))
  }
}
