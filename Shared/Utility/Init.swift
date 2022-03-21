import Foundation

// swiftlint:disable identifier_name
/// A function to create, customize and return an object.
///
/// Example:
/// ```
/// let label = Init(UILabel()) {
///   $0.text = ...
///   $0.textColor = ...
/// }
/// ```
public func Init<Type>(_ object: Type, _ update: Closure<Type>) -> Type {
  update(object)
  return object
}

/// A function to create, customize and map to a different object.
///
/// Example:
/// ```
/// let collectionView: UICollectionView = MapInit(UICollectionViewFlowLayout()) {
///   $0.minimumLineSpacing = ...
///   return UICollectionView(frame: .zero, collectionViewLayout: $0)
/// }
public func MapInit<Type, Result>(_ object: Type, _ transform: Transform<Type, Result>) -> Result {
  return transform(object)
}
