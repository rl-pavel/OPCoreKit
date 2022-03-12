import Foundation

public extension NSError {
  convenience init(_ description: String, withCode code: Int = -1) {
    let bundleInfo = Bundle.main.infoDictionary
    let bundleDisplayName = bundleInfo?[kCFBundleNameKey as String] as? String ?? ""
    self.init(domain: bundleDisplayName, code: code, userInfo: [NSLocalizedDescriptionKey: description])
  }
}
