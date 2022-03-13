import Combine
import SwiftUI

#if canImport(ComposableArchitecture)
import ComposableArchitecture

// MARK: - Store

public typealias StoreFor<S: StateType> = Store<S, S.Action>
public typealias ViewStoreFor<S: StateType> = ViewStore<S, S.Action>


// MARK: -  State

public protocol StateType: Equatable {
  associatedtype Action
  associatedtype Environment

  typealias ReducerType = Reducer<Self, Action, Environment>

  static func reduce(
    state: inout Self,
    action: Action,
    environment: Environment) -> Effect<Action, Never>
}

public extension  StateType {
  static var reducer: ReducerType { Reducer(reduce) }
}

#if DEBUG
public extension  Store where State: StateType {
  static func mock(_ state: State, environment: State.Environment) -> Store<State, State.Action> {
    .init(initialState: state, reducer: State.reducer, environment: environment)
  }
}
#endif


// MARK: - Effect

public typealias EffectFactory<S, E: Error> = Factory<Effect<S, E>>

public extension  Effect {
  init(anyPublisher: AnyPublisher<Output, Failure>) {
    self.init(anyPublisher)
  }

  init(_ subscriberAction: @escaping Transform<AnyPublisher<Output, Failure>.Subscriber, AnyCancellable>) {
    self.init(anyPublisher: .init(subscriberAction))
  }
}


// MARK: - View

public protocol ComposableView: View {
  associatedtype ViewState: StateType
  associatedtype Content: View

  var store: StoreFor<ViewState> { get }
  func body(with viewStore: ViewStoreFor<ViewState>) -> Content
}

public extension  ComposableView {
  var body: some View {
    WithViewStore(store) { viewStore in
      body(with: viewStore)
    }
  }
}

public extension  View {
  func synchronize<Value: Equatable>(
    _ first: Binding<Value>,
    _ second: FocusState<Value>.Binding
  ) -> some View {
    self
      .onChange(of: first.wrappedValue) { second.wrappedValue = $0 }
      .onChange(of: second.wrappedValue) { first.wrappedValue = $0 }
  }
}
#endif
