import PlatformKit
import SwiftUI

public struct SystemFont: FontProtocol {
  public var weight: Font.Weight
  public var textStyle: Font.TextStyle
  
  /// Returns the system SwiftUI Font for the specified style and weight.
  public var font: Font {
    .system(textStyle).weight(weight)
  }
  
  /// Returns the platform (UIFont/NSFont) system font for the specified style and weight.
  public var platformFont: PlatformFont {
#if canImport(UIKit)
    let baseFont = UIFont.systemFont(ofSize: pointSize, weight: weight.platform)
    return UIFontMetrics(forTextStyle: textStyle.platform).scaledFont(for: baseFont)
#else
    NSFont.systemFont(ofSize: pointSize, weight: weight.platform)
#endif
  }
  
  public init(style: Font.TextStyle, weight: Font.Weight) {
    self.weight = weight
    self.textStyle = style
  }
}

public extension FontType {
  /// 34pts regular.
  static var systemLargeTitle: FontType<SystemFont> {
    .init(style: .largeTitle, weight: .regular)
  }

  /// 24pts regular.
  static var systemTitle1: FontType<SystemFont> {
    .init(style: .title, weight: .regular)
  }

  /// 22pts regular.
  static var systemTitle2: FontType<SystemFont> {
    .init(style: .title2, weight: .regular)
  }

  /// 20pts regular.
  static var systemTitle3: FontType<SystemFont> {
    .init(style: .title3, weight: .regular)
  }

  /// 17pts semibold.
  static var systemHeadline: FontType<SystemFont> {
    .init(style: .headline, weight: .semibold)
  }

  /// 17pts regular.
  static var systemBody: FontType<SystemFont> {
    .init(style: .body, weight: .regular)
  }

  /// 16pts regular.
  static var systemCallout: FontType<SystemFont> {
    .init(style: .callout, weight: .regular)
  }

  /// 15pts regular.
  static var systemSubheadline: FontType<SystemFont> {
    .init(style: .subheadline, weight: .regular)
  }

  /// 13pts regular.
  static var systemFootnote: FontType<SystemFont> {
    .init(style: .footnote, weight: .regular)
  }

  /// 12pts regular.
  static var systemCaption1: FontType<SystemFont> {
    .init(style: .caption, weight: .regular)
  }

  /// 11pts regular.
  static var systemCaption2: FontType<SystemFont> {
    .init(style: .caption2, weight: .regular)
  }
}


// MARK: - Preview

#if DEBUG
struct SystemFont_Previews: PreviewProvider {
  struct StylePreview: Identifiable {
    let id: UUID = .init()
    
    let textStyle: FontType<SystemFont>
    let maxWidth: CGFloat
    
    static let text: String = "The quick brown fox jumps over the lazy dog"
    static let allStyles: [StylePreview] = [
      .init(textStyle: .systemLargeTitle, maxWidth: 360),
      .init(textStyle: .systemTitle1, maxWidth: 360),
      .init(textStyle: .systemTitle2, maxWidth: 360),
      .init(textStyle: .systemTitle3, maxWidth: 360),
      
        .init(textStyle: .systemHeadline, maxWidth: 280),
      .init(textStyle: .systemBody, maxWidth: 280),
      .init(textStyle: .systemCallout, maxWidth: 280),
      .init(textStyle: .systemSubheadline, maxWidth: 280),
      
        .init(textStyle: .systemFootnote, maxWidth: 200),
      .init(textStyle: .systemCaption1, maxWidth: 200),
      .init(textStyle: .systemCaption2, maxWidth: 200),
    ]
  }
  
  struct NativeFontPreview: Identifiable {
    let id: UUID = .init()
    
    let font: Font
    let maxWidth: CGFloat
    
    static let nativeFonts: [NativeFontPreview] = [
      .init(font: .system(.largeTitle, design: .default), maxWidth: 360),
      .init(font: .system(.title, design: .default), maxWidth: 360),
      .init(font: .system(.title2, design: .default), maxWidth: 360),
      .init(font: .system(.title3, design: .default), maxWidth: 360),
      
        .init(font: .system(.headline, design: .default), maxWidth: 280),
      .init(font: .system(.body, design: .default), maxWidth: 280),
      .init(font: .system(.callout, design: .default), maxWidth: 280),
      .init(font: .system(.subheadline, design: .default), maxWidth: 280),
      
        .init(font: .system(.footnote, design: .default), maxWidth: 200),
      .init(font: .system(.caption, design: .default), maxWidth: 200),
      .init(font: .system(.caption2, design: .default), maxWidth: 200),
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
