/// A function to create, customize and return an object.
///
/// Example:
/// ```
/// let label = update(UILabel()) {
///   $0.text = ...
/// }
/// ```
public func update<Type>(_ object: Type, _ update: Closure<Type>) -> Type {
  update(object)
  return object
}

/// A function to create, customize and map to a different object.
///
/// Example:
/// ```
/// let collectionView: UICollectionView = transform(UICollectionViewFlowLayout()) {
///   $0.minimumLineSpacing = ...
///   return UICollectionView(frame: .zero, collectionViewLayout: $0)
/// }
public func transform<Type, Result>(_ object: Type, _ transform: Transform<Type, Result>) -> Result {
  return transform(object)
}
