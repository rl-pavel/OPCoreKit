import Combine
import Foundation

/// AnyPublisher<Result<Success, Failure>, Never>
public typealias AnyResultPublisher<Success, Failure: Error> = AnyPublisher<Result<Success, Failure>, Never>

extension Publisher {
  func mapVoid() -> Publishers.Map<Self, Void> {
    map { _ in Void() }
  }
  
  /// Converts the `Publisher.Output` to `Result` with matching `Success`/`Failure` types,
  /// and `Publisher.Failure` to `Never`.
  func asResult() -> AnyResultPublisher<Output, Failure> {
    map(Result.success)
      .catch { Just(Result.failure($0)) }
      .eraseToAnyPublisher()
  }
  
  /// Subscribes to a publisher, executing the request(s), without handling the result.
  func fireAndForget(storedIn subscriptions: inout Set<AnyCancellable>) {
    self.sink(receiveCompletion: { _ in }, receiveValue: { _ in })
      .store(in: &subscriptions)
  }
}

public extension AnyPublisher where Failure: Error {
  struct Subscriber {
    fileprivate let send: Closure<Output>
    fileprivate let complete: Closure<Subscribers.Completion<Failure>>
    
    func send(_ value: Output) {
      self.send(value)
    }
    
    func send(completion: Subscribers.Completion<Failure>) {
      self.complete(completion)
    }
  }
  
  init(_ closure: (Subscriber) -> AnyCancellable) {
    let subject = PassthroughSubject<Output, Failure>()
    let subscriber = Subscriber(
      send: subject.send,
      complete: subject.send(completion:)
    )
    let cancellable = closure(subscriber)
    
    self = subject
      .handleEvents(receiveCancel: cancellable.cancel)
      .eraseToAnyPublisher()
  }
  
  static func just(_ output: Output) -> AnyPublisher<Output, Failure> {
    Just(output).setFailureType(to: Failure.self).eraseToAnyPublisher()
  }
  
  static func fail(with error: Failure) -> AnyPublisher<Output, Failure> {
    Fail(error: error).eraseToAnyPublisher()
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
