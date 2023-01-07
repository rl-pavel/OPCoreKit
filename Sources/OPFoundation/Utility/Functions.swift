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
/// ```
public func transform<Type, Result>(_ object: Type, _ transform: Transform<Type, Result>) -> Result {
  return transform(object)
}

/// A function that copies a value and provides an inout closure to update it.
///
/// Example:
/// ```
/// struct Foo {
///   var value: String
/// }
/// let initial = Foo(value: "initial")
/// let updated = updateCopy(of: initial) { $0.value = "updated" } // Foo(value: "updated")
/// ```
public func updateCopy<Value>(of value: Value, _ updates: InoutClosure<Value>) -> Value {
  var copy = value
  updates(&copy)
  return copy
}
