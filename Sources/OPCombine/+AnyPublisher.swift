import OPFoundation
import Combine

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
  
  init(_ subscribe: Transform<Subscriber, AnyCancellable>) {
    let subject = PassthroughSubject<Output, Failure>()
    let subscriber = Subscriber(
      send: subject.send,
      complete: subject.send(completion:)
    )
    let cancellable = subscribe(subscriber)
    
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
