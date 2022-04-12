@_exported import SwiftUI

#if canImport(AppKit)
import AppKit
public typealias PlatformViewRepresentable = NSViewRepresentable

#elseif canImport(UIKit)
import UIKit
public typealias PlatformViewRepresentable = UIViewRepresentable
#endif
