import Foundation

public typealias Memoize<Input: Hashable, Output> = Transform<Input, Output>
public typealias RecursiveMemoize<Input: Hashable, Output> = Transform<(Memoize<Input, Output>, Input), Output>

/// Creates a closure that (internally) caches the outputs from given inputs in a dictionary.
///
/// Example:
/// ```
/// let memoizedSqrt: Memoize<Double, Double> = memoized(sqrt)
/// memoizedSin(121)
/// ```
public func memoized<Input: Hashable, Output>(_ transform: @escaping Memoize<Input, Output>) -> Memoize<Input, Output> {
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

/// Creates a closure that (internally) caches the outputs from given inputs in a dictionary.
/// The `transform` closure returns the function to perform the recursive calculation and the input.
///
/// Example:
/// ```
/// let memoizedFibonacci: Memoize<Int, Int> = recursiveMemoized { fibonacci, number in
///   number < 2 ? number : fibonacci(number - 1) + fibonacci(number - 2)
/// }
/// ```
public func recursiveMemoized<Input: Hashable, Output>(
  _ transform: @escaping RecursiveMemoize<Input, Output>
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
