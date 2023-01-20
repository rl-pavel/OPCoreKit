import PlatformKit
import SwiftUI

@available(iOS 16.0, *)
@available(macOS 13.0, *)
public struct SystemRoundedFont: SystemDesignedFont {
  public var weight: Font.Weight
  public var textStyle: Font.TextStyle
  public let design: Font.Design = .rounded
  
  public init(style: Font.TextStyle, weight: Font.Weight) {
    self.weight = weight
    self.textStyle = style
  }
}

@available(iOS 16.0, *)
@available(macOS 13.0, *)
public extension FontType {
  /// 34pts regular.
  static var roundedLargeTitle: FontType<SystemRoundedFont> {
    .init(style: .largeTitle, weight: .regular)
  }
  
  /// 24pts regular.
  static var roundedTitle1: FontType<SystemRoundedFont> {
    .init(style: .title, weight: .regular)
  }
  
  /// 22pts regular.
  static var roundedTitle2: FontType<SystemRoundedFont> {
    .init(style: .title2, weight: .regular)
  }
  
  /// 20pts regular.
  static var roundedTitle3: FontType<SystemRoundedFont> {
    .init(style: .title3, weight: .regular)
  }
  
  /// 17pts semibold.
  static var roundedHeadline: FontType<SystemRoundedFont> {
    .init(style: .headline, weight: .semibold)
  }
  
  /// 17pts regular.
  static var roundedBody: FontType<SystemRoundedFont> {
    .init(style: .body, weight: .regular)
  }
  
  /// 16pts regular.
  static var roundedCallout: FontType<SystemRoundedFont> {
    .init(style: .callout, weight: .regular)
  }
  
  /// 15pts regular.
  static var roundedSubheadline: FontType<SystemRoundedFont> {
    .init(style: .subheadline, weight: .regular)
  }
  
  /// 13pts regular.
  static var roundedFootnote: FontType<SystemRoundedFont> {
    .init(style: .footnote, weight: .regular)
  }
  
  /// 12pts regular.
  static var roundedCaption1: FontType<SystemRoundedFont> {
    .init(style: .caption, weight: .regular)
  }
  
  /// 11pts regular.
  static var roundedCaption2: FontType<SystemRoundedFont> {
    .init(style: .caption2, weight: .regular)
  }
}


// MARK: - Preview

#if DEBUG
@available(iOS 16.0, *)
@available(macOS 13.0, *)
struct SystemRoundedFont_Previews: PreviewProvider {
  struct StylePreview: Identifiable {
    let id: UUID = .init()
    
    let textStyle: FontType<SystemRoundedFont>
    let maxWidth: CGFloat
    
    static let text: String = "The quick brown fox jumps over the lazy dog"
    static let allStyles: [StylePreview] = [
      .init(textStyle: .roundedLargeTitle, maxWidth: 360),
      .init(textStyle: .roundedTitle1, maxWidth: 360),
      .init(textStyle: .roundedTitle2, maxWidth: 360),
      .init(textStyle: .roundedTitle3, maxWidth: 360),
      
        .init(textStyle: .roundedHeadline, maxWidth: 280),
      .init(textStyle: .roundedBody, maxWidth: 280),
      .init(textStyle: .roundedCallout, maxWidth: 280),
      .init(textStyle: .roundedSubheadline, maxWidth: 280),
      
        .init(textStyle: .roundedFootnote, maxWidth: 200),
      .init(textStyle: .roundedCaption1, maxWidth: 200),
      .init(textStyle: .roundedCaption2, maxWidth: 200),
    ]
  }
  
  struct NativeFontPreview: Identifiable {
    let id: UUID = .init()
    
    let font: Font
    let maxWidth: CGFloat
    
    static let nativeFonts: [NativeFontPreview] = [
      .init(font: .system(.largeTitle, design: .rounded), maxWidth: 360),
      .init(font: .system(.title, design: .rounded), maxWidth: 360),
      .init(font: .system(.title2, design: .rounded), maxWidth: 360),
      .init(font: .system(.title3, design: .rounded), maxWidth: 360),
      
        .init(font: .system(.headline, design: .rounded), maxWidth: 280),
      .init(font: .system(.body, design: .rounded), maxWidth: 280),
      .init(font: .system(.callout, design: .rounded), maxWidth: 280),
      .init(font: .system(.subheadline, design: .rounded), maxWidth: 280),
      
        .init(font: .system(.footnote, design: .rounded), maxWidth: 200),
      .init(font: .system(.caption, design: .rounded), maxWidth: 200),
      .init(font: .system(.caption2, design: .rounded), maxWidth: 200),
    ]
  }
  
  struct Preview: View {
    @State var showNative: Bool = false
    
    var body: some View {
      VStack {
        Toggle("Overlay Native Fonts", isOn: $showNative)
        
        ZStack {
          VStack(alignment: .leading, spacing: 0) {
            ForEach(StylePreview.allStyles) {
              Text("The quick brown fox jumps over the lazy dog")
                .applyStyle($0.textStyle)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: $0.maxWidth, alignment: .leading)
                .padding(.bottom, 8)
                .background(Color.black.opacity(0.1))
            }
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
          
          if showNative {
            VStack(alignment: .leading, spacing: 0) {
              ForEach(NativeFontPreview.nativeFonts) {
                Text("The quick brown fox jumps over the lazy dog")
                  .font($0.font)
                  .fixedSize(horizontal: false, vertical: true)
                  .frame(maxWidth: $0.maxWidth, alignment: .leading)
                  .padding(.bottom, 8)
                  .background(Color.black.opacity(0.1))
              }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
          }
        }
      }
    }
  }
  
  static var previews: some View {
    Preview()
      .padding(8)
  }
}
#endif
