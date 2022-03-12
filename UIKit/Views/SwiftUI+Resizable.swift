import SwiftUI
#if canImport(UIKit)
import UIKit

// TODO: - Deprecate when Apple fixes this mess - reproducible example in the preview below.

/// This protocol defines a view whose size may change after the initial layout.
/// The purpose of this is to fix a (hopefully temporary) iOS 15 bug where the `UIHostingController`'s view
/// doesn't update it's size to fit the SwiftUI View content properly.
///
/// 1 : Conform the view struct to `Resizable` and add the `updateSize` property.
///
/// 2 : Whenever the content changes in the `body`, call `updateSize?()` or add a size reader modifier
/// at the end: `.readSize { _ in updateSize?() }`.
///
/// ```
/// struct SomeView: View, Resizable {
///   var updateSize: VoidClosure?
///
///   var body: some View {
///      <some_content>
///        .readSize { _ in updateSize?() }
///   }
/// }
/// ```
///
/// 3 : Whenever the `UIHostingController.rootView` is set, call `hostController.configureResizableViewIfNeeded()`.
/// This is done automatically during init in `Host`, but has to be called whenever the `rootView` is updated,
/// e.g. if the `Content` is optional and initially `nil`, or if the `rootView` is mutated from the outside.
public protocol Resizable {
  var updateSize: VoidClosure? { get set }
}

public extension UIHostingController {
  func configureResizableViewIfNeeded() {
    guard #available(iOS 15.0, *), var resizingView = rootView as? Resizable else { return }
    
    resizingView.updateSize = { [weak self] in
      self?.view?.setNeedsUpdateConstraints()
    }
    
    // swiftlint:disable:next force_cast
    rootView = resizingView  as! Content
  }
}


// MARK: - Preview

#if DEBUG
struct ResizableHelper_Previews: PreviewProvider {
  struct Preview: View, Resizable {
    @State var viewHeight: CGFloat = 100
    var updateSize: VoidClosure?
    
    var body: some View {
      VStack {
        HStack {
          Text("iOS \(UIDevice.current.systemVersion) - \(updateSize == nil ? "🤬" : "fixed")")
          Spacer()
          Text("Height: \(Int(viewHeight))")
        }
        Slider(value: $viewHeight, in: 100...300)
      }
      .padding(.horizontal)
      .frame(height: viewHeight)
      .background(Color.gray)
      .padding(.horizontal)
      .readSize { _ in updateSize?() }
    }
  }
  
  struct IOS15SizeReproductionController: UIViewControllerRepresentable {
    let updateSize: Bool
    
    func makeUIViewController(context: Context) -> UIViewController {
      let hostController = Host<Preview?>(nil)
      hostController.view.backgroundColor = .red
      hostController.rootView = .init()
      if updateSize { hostController.configureResizableViewIfNeeded() }
      
      let wrapperController = UIViewController()
      let wrapperView = wrapperController.view!
      wrapperController.addController(hostController)
      
      let hostView = hostController.view!
      hostView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        hostView.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor),
        hostView.centerYAnchor.constraint(equalTo: wrapperView.centerYAnchor),
        hostView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
        hostView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor)
      ])
      return wrapperController
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }
  }
  
  static var previews: some View {
    VStack {
      IOS15SizeReproductionController(updateSize: true)
      IOS15SizeReproductionController(updateSize: false)
    }
  }
}
#endif
#endif
