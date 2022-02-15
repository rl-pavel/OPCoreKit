import UIKit
import SwiftUI

public extension UITraitCollection {
  var isNormalSize: Bool {
    preferredContentSizeCategory < .extraExtraExtraLarge
  }
  
  var isLargeSize: Bool {
    preferredContentSizeCategory >= .extraExtraExtraLarge
  }
}
