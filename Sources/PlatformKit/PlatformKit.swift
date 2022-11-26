import SwiftUI

#if canImport(UIKit)
@_exported import UIKit
public typealias PlatformColor = UIColor
public typealias PlatformFont = UIFont

public typealias PlatformViewRepresentable = UIViewRepresentable
public typealias PlatformView = UIView
public typealias PlatformViewController = UIViewController
public typealias PlatformApplication = UIApplication
public typealias PlatformResponder = UIResponder
public typealias PlatformTextView = UITextView

#elseif canImport(AppKit)
@_exported import AppKit
public typealias PlatformColor = NSColor
public typealias PlatformFont = NSFont

public typealias PlatformViewRepresentable = NSViewRepresentable
public typealias PlatformView = NSView
public typealias PlatformViewController = NSViewController
public typealias PlatformApplication = NSApplication
public typealias PlatformResponder = NSResponder

public typealias PlatformTextView = NSTextView
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
