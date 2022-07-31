import Foundation

public typealias Memoize<Input: Hashable, Output> = Transform<Input, Output>
public typealias RecursiveMemoize<Input: Hashable, Output> = Transform<(Memoize<Input, Output>, Input), Output>

/// Example:
///
/// let memoizedSqrt: Memoize<Double, Double> = memoize(sqrt)
/// memoizedSin(121)
public func memoize<Input: Hashable, Output>(_ transform: @escaping Transform<Input, Output>) -> Memoize<Input, Output> {
  var storage: [Input: Output] = [:]
  
  return { input in
    if let value = storage[input] {
      return value
    }
    
    let result = transform(input)
    storage[input] = result
    return result
  }
}

/// Example:
///
/// let memoizedFibonacci: RecursiveMemoize<Int, Int> = recursiveMemoize { fibonacci, number in
///   number < 2 ? number : fibonacci(number - 1) + fibonacci(number - 2)
/// }
public func recursiveMemoize<Input: Hashable, Output>(
  _ transform: @escaping Transform<(Transform<Input, Output>, Input), Output>
) -> Memoize<Input, Output> {
  var storage: [Input: Output] = [:]
  var memoizer: Transform<Input, Output>!
  
  memoizer = { input in
    if let value = storage[input] {
      return value
    }
    
    let result = transform((memoizer, input))
    storage[input] = result
    return result
  }
  
  return memoizer
}
