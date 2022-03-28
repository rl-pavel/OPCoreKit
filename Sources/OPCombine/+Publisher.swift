import OPFoundation
import Combine

/// AnyPublisher<Result<Success, Failure>, Never>
public typealias AnyResultPublisher<Success, Failure: Error> = AnyPublisher<Result<Success, Failure>, Never>

public extension Publisher {
  /// Converts the `Publisher.Output` to `Result` with matching `Success`/`Failure` types,
  /// and `Publisher.Failure` to `Never`.
  func asResult() -> AnyResultPublisher<Output, Failure> {
    map(Result.success)
      .catch { Just(Result.failure($0)) }
      .eraseToAnyPublisher()
  }
  
  func ignoreOutput<NewOutput>(setOutputType: NewOutput.Type) -> AnyPublisher<NewOutput, Failure> {
    ignoreOutput()
      .setOutputType(to: NewOutput.self)
  }
  
  func ignoreFailure<NewFailure>(setFailureType: NewFailure.Type) -> AnyPublisher<Output, NewFailure> {
    self.catch { _ in Empty() }
      .setFailureType(to: NewFailure.self)
      .eraseToAnyPublisher()
  }
  
  func ignoreFailure() -> AnyPublisher<Output, Never> {
    self.catch { _ in Empty() }
      .setFailureType(to: Never.self)
      .eraseToAnyPublisher()
  }
}


public extension Publisher where Output == Never {
  func sink(receiveCompletion: @escaping Closure<Subscribers.Completion<Failure>>) -> AnyCancellable {
    sink(receiveCompletion: receiveCompletion, receiveValue: { _ in })
  }
  
  func setOutputType<NewOutput>(to _: NewOutput.Type) -> AnyPublisher<NewOutput, Failure> {
    func absurd<A>(_ never: Never) -> A {}
    return map(absurd).eraseToAnyPublisher()
  }
}

public extension Subscribers.Completion {
  var isSuccess: Bool {
    switch self {
    case .finished: return true
    case .failure: return false
    }
  }
}
