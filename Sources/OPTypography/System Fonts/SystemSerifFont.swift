import PlatformKit
import SwiftUI

@available(iOS 16.0, *)
@available(macOS 13.0, *)
public struct SystemSerifFont: SystemDesignedFont {
  public var weight: Font.Weight
  public var textStyle: Font.TextStyle
  public let design: Font.Design = .serif
  
  public init(style: Font.TextStyle, weight: Font.Weight) {
    self.weight = weight
    self.textStyle = style
  }
}

@available(iOS 16.0, *)
@available(macOS 13.0, *)
public extension FontType {
  /// 34pts regular.
  static var serifLargeTitle: FontType<SystemSerifFont> {
    .init(style: .largeTitle, weight: .regular)
  }
  
  /// 24pts regular.
  static var serifTitle1: FontType<SystemSerifFont> {
    .init(style: .title, weight: .regular)
  }
  
  /// 22pts regular.
  static var serifTitle2: FontType<SystemSerifFont> {
    .init(style: .title2, weight: .regular)
  }
  
  /// 20pts regular.
  static var serifTitle3: FontType<SystemSerifFont> {
    .init(style: .title3, weight: .regular)
  }
  
  /// 17pts semibold.
  static var serifHeadline: FontType<SystemSerifFont> {
    .init(style: .headline, weight: .semibold)
  }
  
  /// 17pts regular.
  static var serifBody: FontType<SystemSerifFont> {
    .init(style: .body, weight: .regular)
  }
  
  /// 16pts regular.
  static var serifCallout: FontType<SystemSerifFont> {
    .init(style: .callout, weight: .regular)
  }
  
  /// 15pts regular.
  static var serifSubheadline: FontType<SystemSerifFont> {
    .init(style: .subheadline, weight: .regular)
  }
  
  /// 13pts regular.
  static var serifFootnote: FontType<SystemSerifFont> {
    .init(style: .footnote, weight: .regular)
  }
  
  /// 12pts regular.
  static var serifCaption1: FontType<SystemSerifFont> {
    .init(style: .caption, weight: .regular)
  }
  
  /// 11pts regular.
  static var serifCaption2: FontType<SystemSerifFont> {
    .init(style: .caption2, weight: .regular)
  }
}


// MARK: - Preview

#if DEBUG
@available(iOS 16.0, *)
@available(macOS 13.0, *)
struct SystemSerifFont_Previews: PreviewProvider {
  struct StylePreview: Identifiable {
    let id: UUID = .init()
    
    let textStyle: FontType<SystemSerifFont>
    let maxWidth: CGFloat
    
    static let text: String = "The quick brown fox jumps over the lazy dog"
    static let allStyles: [StylePreview] = [
      .init(textStyle: .serifLargeTitle, maxWidth: 360),
      .init(textStyle: .serifTitle1, maxWidth: 360),
      .init(textStyle: .serifTitle2, maxWidth: 360),
      .init(textStyle: .serifTitle3, maxWidth: 360),
      
        .init(textStyle: .serifHeadline, maxWidth: 280),
      .init(textStyle: .serifBody, maxWidth: 280),
      .init(textStyle: .serifCallout, maxWidth: 280),
      .init(textStyle: .serifSubheadline, maxWidth: 280),
      
        .init(textStyle: .serifFootnote, maxWidth: 200),
      .init(textStyle: .serifCaption1, maxWidth: 200),
      .init(textStyle: .serifCaption2, maxWidth: 200),
    ]
  }
  
  struct NativeFontPreview: Identifiable {
    let id: UUID = .init()
    
    let font: Font
    let maxWidth: CGFloat
    
    static let nativeFonts: [NativeFontPreview] = [
      .init(font: .system(.largeTitle, design: .serif), maxWidth: 360),
      .init(font: .system(.title, design: .serif), maxWidth: 360),
      .init(font: .system(.title2, design: .serif), maxWidth: 360),
      .init(font: .system(.title3, design: .serif), maxWidth: 360),
      
        .init(font: .system(.headline, design: .serif), maxWidth: 280),
      .init(font: .system(.body, design: .serif), maxWidth: 280),
      .init(font: .system(.callout, design: .serif), maxWidth: 280),
      .init(font: .system(.subheadline, design: .serif), maxWidth: 280),
      
        .init(font: .system(.footnote, design: .serif), maxWidth: 200),
      .init(font: .system(.caption, design: .serif), maxWidth: 200),
      .init(font: .system(.caption2, design: .serif), maxWidth: 200),
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
