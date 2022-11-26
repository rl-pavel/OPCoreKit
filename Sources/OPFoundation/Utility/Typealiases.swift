public typealias VoidClosure = () -> Void
public typealias Closure<Input> = (Input) -> Void
public typealias Factory<Result> = () -> Result
public typealias Transform<Input, Result> = (Input) -> Result
