@_exported import SwiftUI

public protocol UniversalViewRepresentable: PlatformViewRepresentable {
  associatedtype ViewType: PlatformView
  func makeUniversalView(context: Context) -> ViewType
  func updateUniversalView(_ view: ViewType, context: Context)
}

#if os(iOS)
import UIKit
public typealias PlatformViewRepresentable = UIViewRepresentable
public typealias PlatformView = UIView
public typealias PlatformViewController = UIViewController
public typealias PlatformApplication = UIApplication
public typealias PlatformResponder = UIResponder

public typealias PlatformTextView = UITextView

public extension UniversalViewRepresentable where UIViewType == ViewType {
  func makeUIView(context: Context) -> ViewType {
    makeUniversalView(context: context)
  }
  
  func updateUIView(_ view: ViewType, context: Context) {
    updateUniversalView(view, context: context)
  }
}

#elseif os(macOS)
import AppKit
public typealias PlatformViewRepresentable = NSViewRepresentable
public typealias PlatformView = NSView
public typealias PlatformViewController = NSViewController
public typealias PlatformApplication = NSApplication
public typealias PlatformResponder = NSResponder

public typealias PlatformTextView = NSTextView

public extension UniversalViewRepresentable where NSViewType == ViewType {
  func makeNSView(context: Context) -> ViewType {
    makeUniversalView(context: context)
  }
  
  func updateNSView(_ view: ViewType, context: Context) {
    updateUniversalView(view, context: context)
  }
}
#endif


public extension PlatformResponder {
  var nextPlatformResponder: PlatformResponder? {
#if os(iOS)
    return self.next
#elseif os(macOS)
    return self.nextResponder
#endif
  }
}
