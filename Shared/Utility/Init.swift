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
func Init<Type>(_ object: Type, _ customize: (Type) -> Void) -> Type {
  customize(object)
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
func MapInit<Type, Result>(_ object: Type, _ customize: (Type) -> Result) -> Result {
  return customize(object)
}
