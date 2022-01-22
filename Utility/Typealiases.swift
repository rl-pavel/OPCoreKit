import Foundation

public typealias VoidClosure = () -> Void
public typealias Closure<T> = (T) -> Void
public typealias Factory<T> = () -> T
public typealias Transform<T, U> = (T) -> U
