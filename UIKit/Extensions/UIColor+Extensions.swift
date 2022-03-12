#if canImport(UIKit)
import UIKit

public extension UIColor {
  convenience init(hex: Int, alpha: CGFloat = 1.0) {
    self.init(red: (hex >> 16) & 0xFF, green: (hex >> 8) & 0xFF, blue: hex & 0xFF)
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
#endif
