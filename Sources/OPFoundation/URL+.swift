import Foundation

public extension URL {
  var ubiquityStatus: URLUbiquitousItemDownloadingStatus? {
    resourceValue(forKey: .ubiquitousItemDownloadingStatusKey) as? URLUbiquitousItemDownloadingStatus
  }
  
  func resourceValue(forKey key: URLResourceKey) -> Any? {
    try? resourceValues(forKeys: [key]).allValues.first?.value
  }
  
  func withPath(_ components: String...) -> URL {
    components.reduce(self) { $0.appendingPathComponent($1) }
  }
  
  func withPath(_ components: String..., ext: String) -> URL {
    components
      .reduce(self) { $0.appendingPathComponent($1) }
      .appendingPathExtension(ext)
  }
}
