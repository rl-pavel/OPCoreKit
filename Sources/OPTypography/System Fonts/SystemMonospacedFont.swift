import PlatformKit
import SwiftUI

@available(iOS 16.0, *)
@available(macOS 13.0, *)
public struct SystemMonospacedFont: SystemDesignedFont {
  public var weight: Font.Weight
  public var textStyle: Font.TextStyle
  public let design: Font.Design = .monospaced
  
  public init(style: Font.TextStyle, weight: Font.Weight) {
    self.weight = weight
    self.textStyle = style
  }
}

@available(iOS 16.0, *)
@available(macOS 13.0, *)
public extension FontType {
  /// 34pts regular.
  static var monospacedLargeTitle: FontType<SystemMonospacedFont> {
    .init(style: .largeTitle, weight: .regular)
  }
  
  /// 24pts regular.
  static var monospacedTitle1: FontType<SystemMonospacedFont> {
    .init(style: .title, weight: .regular)
  }
  
  /// 22pts regular.
  static var monospacedTitle2: FontType<SystemMonospacedFont> {
    .init(style: .title2, weight: .regular)
  }
  
  /// 20pts regular.
  static var monospacedTitle3: FontType<SystemMonospacedFont> {
    .init(style: .title3, weight: .regular)
  }
  
  /// 17pts semibold.
  static var monospacedHeadline: FontType<SystemMonospacedFont> {
    .init(style: .headline, weight: .semibold)
  }
  
  /// 17pts regular.
  static var monospacedBody: FontType<SystemMonospacedFont> {
    .init(style: .body, weight: .regular)
  }
  
  /// 16pts regular.
  static var monospacedCallout: FontType<SystemMonospacedFont> {
    .init(style: .callout, weight: .regular)
  }
  
  /// 15pts regular.
  static var monospacedSubheadline: FontType<SystemMonospacedFont> {
    .init(style: .subheadline, weight: .regular)
  }
  
  /// 13pts regular.
  static var monospacedFootnote: FontType<SystemMonospacedFont> {
    .init(style: .footnote, weight: .regular)
  }
  
  /// 12pts regular.
  static var monospacedCaption1: FontType<SystemMonospacedFont> {
    .init(style: .caption, weight: .regular)
  }
  
  /// 11pts regular.
  static var monospacedCaption2: FontType<SystemMonospacedFont> {
    .init(style: .caption2, weight: .regular)
  }
}


// MARK: - Preview

#if DEBUG
@available(iOS 16.0, *)
@available(macOS 13.0, *)
struct SystemMonospacedFont_Previews: PreviewProvider {
  struct StylePreview: Identifiable {
    let id: UUID = .init()
    
    let textStyle: FontType<SystemMonospacedFont>
    let maxWidth: CGFloat
    
    static let text: String = "The quick brown fox jumps over the lazy dog"
    static let allStyles: [StylePreview] = [
      .init(textStyle: .monospacedLargeTitle, maxWidth: 360),
      .init(textStyle: .monospacedTitle1, maxWidth: 360),
      .init(textStyle: .monospacedTitle2, maxWidth: 360),
      .init(textStyle: .monospacedTitle3, maxWidth: 360),
      
        .init(textStyle: .monospacedHeadline, maxWidth: 280),
      .init(textStyle: .monospacedBody, maxWidth: 280),
      .init(textStyle: .monospacedCallout, maxWidth: 280),
      .init(textStyle: .monospacedSubheadline, maxWidth: 280),
      
        .init(textStyle: .monospacedFootnote, maxWidth: 200),
      .init(textStyle: .monospacedCaption1, maxWidth: 200),
      .init(textStyle: .monospacedCaption2, maxWidth: 200),
    ]
  }
  
  struct NativeFontPreview: Identifiable {
    let id: UUID = .init()
    
    let font: Font
    let maxWidth: CGFloat
    
    static let nativeFonts: [NativeFontPreview] = [
      .init(font: .system(.largeTitle, design: .monospaced), maxWidth: 360),
      .init(font: .system(.title, design: .monospaced), maxWidth: 360),
      .init(font: .system(.title2, design: .monospaced), maxWidth: 360),
      .init(font: .system(.title3, design: .monospaced), maxWidth: 360),
      
        .init(font: .system(.headline, design: .monospaced), maxWidth: 280),
      .init(font: .system(.body, design: .monospaced), maxWidth: 280),
      .init(font: .system(.callout, design: .monospaced), maxWidth: 280),
      .init(font: .system(.subheadline, design: .monospaced), maxWidth: 280),
      
        .init(font: .system(.footnote, design: .monospaced), maxWidth: 200),
      .init(font: .system(.caption, design: .monospaced), maxWidth: 200),
      .init(font: .system(.caption2, design: .monospaced), maxWidth: 200),
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
