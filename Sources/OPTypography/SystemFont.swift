import SwiftUI
import OPFoundation

public struct SystemFont: FontType {
  public var weight: Font.Weight
  public var style: TypeStyle
  
  public init(style: TypeStyle, weight: Font.Weight) {
    self.weight = weight
    self.style = style
  }
}

public extension TextStyle {
  /// 34pts regular.
  static var systemLargeTitle: TextStyle<SystemFont> {
    .init(style: .largeTitle, weight: .regular, lineHeight: 0, tracking: 0.40)
  }

  /// 24pts regular.
  static var systemTitle1: TextStyle<SystemFont> {
    .init(style: .title1, weight: .regular, lineHeight: 0, tracking: 0.07)
  }

  /// 22pts regular.
  static var systemTitle2: TextStyle<SystemFont> {
    .init(style: .title2, weight: .regular, lineHeight: 0, tracking: -0.26)
  }

  /// 20pts regular.
  static var systemTitle3: TextStyle<SystemFont> {
    .init(style: .title3, weight: .regular, lineHeight: 0, tracking: -0.45)
  }

  /// 17pts semibold.
  static var systemHeadline: TextStyle<SystemFont> {
    .init(style: .headline, weight: .semibold, lineHeight: 0, tracking: -0.43)
  }

  /// 17pts regular.
  static var systemBody: TextStyle<SystemFont> {
    .init(style: .body, weight: .regular, lineHeight: 0, tracking: -0.43)
  }

  /// 16pts regular.
  static var systemCallout: TextStyle<SystemFont> {
    .init(style: .callout, weight: .regular, lineHeight: 0, tracking: -0.31)
  }

  /// 15pts regular.
  static var systemSubheadline: TextStyle<SystemFont> {
    .init(style: .subheadline, weight: .regular, lineHeight: 0, tracking: -0.23)
  }

  /// 13pts regular.
  static var systemFootnote: TextStyle<SystemFont> {
    .init(style: .footnote, weight: .regular, lineHeight: 0, tracking: -0.15)
  }

  /// 12pts regular.
  static var systemCaption1: TextStyle<SystemFont> {
    .init(style: .caption1, weight: .regular, lineHeight: 0, tracking: 0)
  }

  /// 11pts regular.
  static var systemCaption2: TextStyle<SystemFont> {
    .init(style: .caption2, weight: .regular, lineHeight: 0, tracking: 0.06)
  }
}


#if DEBUG
struct TextStyles_Previews: PreviewProvider {
  struct StylePreview: Identifiable {
    var id: UUID { .init() }
    
    let style: TextStyle<SystemFont>
    let maxWidth: CGFloat
    
    static let text: String = "The quick brown fox jumps over the lazy dog"
    static let allStyles: [StylePreview] = [
      .init(style: .systemLargeTitle, maxWidth: 360),
      .init(style: .systemTitle1, maxWidth: 360),
      .init(style: .systemTitle2, maxWidth: 360),
      .init(style: .systemTitle3, maxWidth: 360),
      
      .init(style: .systemHeadline, maxWidth: 280),
      .init(style: .systemBody, maxWidth: 280),
      .init(style: .systemCallout, maxWidth: 280),
      .init(style: .systemSubheadline, maxWidth: 280),
      
      .init(style: .systemFootnote, maxWidth: 200),
      .init(style: .systemCaption1, maxWidth: 200),
      .init(style: .systemCaption2, maxWidth: 200),
    ]
  }

  static var previews: some View {
    VStack(alignment: .leading, spacing: 0) {
      ForEach(StylePreview.allStyles) {
        Text("The quick brown fox jumps over the lazy dog")
          .applyStyle($0.style)
          .fixedSize(horizontal: false, vertical: true)
          .frame(maxWidth: $0.maxWidth, alignment: .leading)
          .padding(.bottom, 8)
          .background(Color.black.opacity(0.1))
      }
    }
    .padding(.horizontal, 8)
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
  }
}
#endif
