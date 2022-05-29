import Foundation

public extension FileManager {
  struct SortOption {
    let resourceKey: URLResourceKey
    
    public static let creationDate: SortOption = .init(resourceKey: .creationDateKey)
    public static let modifiedDate: SortOption = .init(resourceKey: .contentModificationDateKey)
    public static let accessedDate: SortOption = .init(resourceKey: .contentAccessDateKey)
  }
  
  func contentsOfDirectory(
    at url: URL,
    sortedBy sortOption: SortOption = .creationDate,
    ascending: Bool = false,
    options: FileManager.DirectoryEnumerationOptions = []) throws -> [URL] {
      let key = sortOption.resourceKey
      
      return try contentsOfDirectory(
        at: url,
        includingPropertiesForKeys: [key, .ubiquitousItemDownloadingStatusKey],
        options: options
      )
      .sorted {
        guard let leftDate = $0.resourceValue(forKey: key) as? Date,
              let rightDate = $1.resourceValue(forKey: key) as? Date else {
          return true
        }
        
        return leftDate.compare(rightDate) == (ascending ? .orderedAscending : .orderedDescending)
      }
    }
}
