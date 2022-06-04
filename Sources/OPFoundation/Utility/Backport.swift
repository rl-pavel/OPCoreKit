/// A namespace layer for creating backwards compatible functionality for new iOS APIs.
///
/// Source: https://davedelong.com/blog/2021/10/09/simplifying-backwards-compatibility-in-swift/
public struct Backport<Content> {
  public let content: Content
  
  public init(_ content: Content) {
    self.content = content
  }
}
