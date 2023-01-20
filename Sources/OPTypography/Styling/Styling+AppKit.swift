// This is a work in progress.
#if canImport(AppKit)
import AppKit

public extension NSTextView {
  func applyStyle() {
    isRichText = false
    allowsUndo = true
  }
  
  func applyStyle<Font: FontProtocol>(
    _ fontType: FontType<Font>,
    color: NSColor,
    alignment: NSTextAlignment = .left) {
      applyStyle()
      font = fontType.platformFont
      textColor = color
      self.alignment = alignment
      typingAttributes = .attributes(for: fontType, color: color, alignment: alignment)
    }
}
#endif
