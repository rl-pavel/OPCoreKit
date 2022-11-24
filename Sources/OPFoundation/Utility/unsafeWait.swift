import Foundation

fileprivate class Box<ResultType> {
  var result: Result<ResultType, Error>? = nil
}

/// Unsafely awaits an async function from a synchronous context.
public func _unsafeWait<ResultType>(_ f: @escaping () async throws -> ResultType) throws -> ResultType {
  let box = Box<ResultType>()
  let semaphore = DispatchSemaphore(value: 0)
  Task {
    do {
      let val = try await f()
      box.result = .success(val)
    } catch {
      box.result = .failure(error)
    }
    semaphore.signal()
  }
  semaphore.wait()
  return try box.result!.get()
}
