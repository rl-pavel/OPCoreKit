public typealias VoidClosure = () -> Void

public typealias Closure<Input> = (Input) -> Void
public typealias AsyncClosure<Input> = (Input) async -> Void
public typealias InoutClosure<Input> = (inout Input) -> Void
public typealias AsyncInoutClosure<Input> = (inout Input) async -> Void

public typealias Factory<Result> = () -> Result
public typealias Transform<Input, Result> = (Input) -> Result
