#if canImport(UIKit)
import UIKit

public extension UITraitCollection {
  var isNormalSize: Bool {
    preferredContentSizeCategory < .extraExtraExtraLarge
  }
  
  var isLargeSize: Bool {
    preferredContentSizeCategory >= .extraExtraExtraLarge
  }
}
#endif
