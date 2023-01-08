import OPFoundation
import PlatformKit
import SwiftUI

// Credit: https://gist.github.com/IanKeen/abb807d72c5843fb0f4c3ab10804b9f7
extension View {
  public func introspect<T: PlatformView>(
    tag: Int = .random(in: (.min)...(.max)),
    where predicate: @escaping (T) -> Bool = { _ in true },
    _ closure: @escaping (T) -> Void
  ) -> some View {
    self.overlay(
      IntrospectView(tag: tag)
        .frame(width: 0, height: 0)
        .onAppear {
          DispatchQueue.main.async {
#if os(iOS)
            let keyWindow = UIApplication.shared.connectedScenes
              .filter { $0.activationState == .foregroundActive }
              .mapFirst { $0 as? UIWindowScene }?
              .windows
              .first(where: \.isKeyWindow)
            let root = keyWindow?.viewWithTag(tag)
#elseif os(macOS)
            let keyWindow = NSApplication.shared.windows.first(where: \.isKeyWindow)
            let root = keyWindow?.contentView?.viewWithTag(tag)
#endif
            
            guard let host = root.flatMap(findViewHost(from:)),
                  let discovered = findClosestView(T.self, host: host, where: predicate)
            else {
              return print("⚠️ Unable to find a view of type '\(T.self)'")
            }
            
            closure(discovered)
          }
        }
    )
  }
}

extension View {
  public func introspect<T: PlatformViewController>(
    where predicate: @escaping (T) -> Bool = { _ in true },
    _ closure: @escaping (T) -> Void
  ) -> some View {
    var match: T?
    
    return introspect(
      where: { (view: PlatformView) in
        guard let controller = view.findViewController() else { return false }
        
        let responderChain = sequence(first: controller, next: \.nextPlatformResponder)
        
        for item in responderChain {
          if let controller = item as? T, predicate(controller) {
            match = controller
            return true
          }
        }
        
        return false
      },
      { _ in
        guard let controller = match else {
          return print("⚠️ Unable to find a view controller of type '\(T.self)'")
        }
        
        closure(controller)
      }
    )
  }
}

private extension PlatformView {
  func findViewController() -> PlatformViewController? {
    if let next = nextPlatformResponder as? PlatformViewController {
      return next
    } else if let next = nextPlatformResponder as? PlatformView {
      return next.findViewController()
    } else {
      return nil
    }
  }
}

private struct IntrospectView: UniversalViewRepresentable {
  class TagView: PlatformView {
#if os(macOS)
    var actualTag: Int = 0
    override var tag: Int {
      get { actualTag }
      set { actualTag = newValue }
    }
#endif
  }
  
  var tag: Int
  
  func makeUniversalView(context: Context) -> PlatformView {
    let view = TagView()
    view.tag = tag
    view.frame = .zero
#if os(iOS)
    view.layer.opacity = 0
    view.isUserInteractionEnabled = false
#elseif os(macOS)
    view.layer?.opacity = 0
#endif
    return view
  }
  
  func updateUniversalView(_ view: PlatformView, context: Context) { }
}

private func findViewHost(from entry: PlatformView) -> PlatformView? {
  var superview = entry.superview
  while let s = superview {
    if NSStringFromClass(type(of: s)).contains("ViewHost") {
      return s
    }
    superview = s.superview
  }
  return nil
}

private func findClosestView<T: PlatformView>(
  _: T.Type = T.self,
  host: PlatformView,
  where predicate: @escaping (T) -> Bool) -> T? {
    // find the view hosts index in it's superview
    // search from that index back to 0
    // - look down the hierarchy at each item for T
    guard
      let superview = host.superview,
      let index = superview.subviews.firstIndex(of: host)
    else { return nil }
    
    let branches = superview.subviews[0...index].reversed()
    
    return branches.lazy.compactMap({ $0.firstView(T.self, where: predicate) }).first
  }

private extension PlatformView {
  func firstView<T: PlatformView>(
    _: T.Type = T.self,
    where predicate: @escaping (T) -> Bool = { _ in true }) -> T? {
      if let result = self as? T, predicate(result) {
        return result
      }
      
      return subviews.lazy
        .compactMap { $0.firstView(where: predicate) }
        .first
    }
}
