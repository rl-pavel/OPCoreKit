public typealias VoidClosure = () -> Void
public typealias Closure<Input> = (Input) -> Void
public typealias Factory<Result> = () -> Result
public typealias Transform<Input, Result> = (Input) -> Result

#if canImport(UIKit)
import UIKit
public typealias PlatformColor = UIColor
public typealias PlatformFont = UIFont

#elseif canImport(AppKit)
import AppKit
public typealias PlatformColor = NSColor
public typealias PlatformFont = NSFont
#endif
