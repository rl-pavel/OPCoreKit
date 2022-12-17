import SwiftUI

// MARK: - UIKit

#if canImport(UIKit)
public extension UIColor {
  convenience init(
      light lightModeColor: @escaping @autoclosure () -> PlatformColor,
      dark darkModeColor: @escaping @autoclosure () -> PlatformColor
   ) {
      self.init { traitCollection in
          switch traitCollection.userInterfaceStyle {
          case .light, .unspecified:
              return lightModeColor()
          case .dark:
              return darkModeColor()
          @unknown default:
              return lightModeColor()
          }
      }
  }
}

public extension Color {
  @_disfavoredOverload
  init(platformColor: PlatformColor) {
    self.init(uiColor: platformColor)
  }
}


// MARK: - AppKit

#elseif canImport(AppKit)
public extension NSColor {
  convenience init(
      light lightModeColor: @escaping @autoclosure () -> PlatformColor,
      dark darkModeColor: @escaping @autoclosure () -> PlatformColor
   ) {
     self.init(name: nil) { appearance in
       switch appearance.name {
       case .aqua, .vibrantLight, .accessibilityHighContrastAqua, .accessibilityHighContrastVibrantLight:
         return lightModeColor()
       case .darkAqua, .vibrantDark, .accessibilityHighContrastDarkAqua, .accessibilityHighContrastVibrantLight:
         return darkModeColor()
       default:
         return lightModeColor()
       }
     }
  }
}

public extension Color {
  @_disfavoredOverload
  init(platformColor: PlatformColor) {
    self.init(nsColor: platformColor)
  }
}
#endif


// MARK: - Platform

public extension PlatformColor {
  convenience init(hex: Int, alpha: CGFloat = 1.0) {
    self.init(red: (hex >> 16) & 0xFF, green: (hex >> 8) & 0xFF, blue: hex & 0xFF, alpha: alpha)
  }
  
  convenience init(greyScale: CGFloat, alpha: CGFloat = 1.0) {
    self.init(red: greyScale, green: greyScale, blue: greyScale, alpha: alpha)
  }
  
  convenience init(hexString: String, alpha: CGFloat = 1.0) {
    var hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
    
    if hexString.hasPrefix("#") {
      hexString.removeFirst()
    }
    
    let scanner = Scanner(string: hexString)
    
    var color: UInt64 = 0
    scanner.scanHexInt64(&color)
    
    self.init(hex: Int(color))
  }
  
  private convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
    assert((0...255).contains(red), "Invalid red component")
    assert((0...255).contains(green), "Invalid green component")
    assert((0...255).contains(blue), "Invalid blue component")
    self.init(
      red: CGFloat(red) / 255.0,
      green: CGFloat(green) / 255.0,
      blue: CGFloat(blue) / 255.0,
      alpha: alpha)
  }
}
