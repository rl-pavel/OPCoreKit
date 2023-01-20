import SwiftUI

public extension Text {
  /// Applies `font`, `foregroundColor`, `multilineTextAlignment`, `tracking` and `lineSpacing`.
  ///
  /// NOTE: `tracking` is only available on iOS 16+ and macOS 13+.
  func applyStyle<Font: FontProtocol>(_ fontType: FontType<Font>) -> some View {
    self
      .font(fontType.font)
      .tracking(fontType.tracking)
      .lineSpacing(fontType.lineSpacing)
  }
  
  /// Applies `font`, `foregroundColor`, `tracking` and `lineSpacing`.
  ///
  /// NOTE: `tracking` is only available on iOS 16+ and macOS 13+.
  func applyStyle<Font: FontProtocol>(_ fontType: FontType<Font>, color: Color) -> some View {
    return applyStyle(fontType)
      .foregroundColor(color)
  }
  
  /// Applies `font`, `multilineTextAlignment`, `tracking` and `lineSpacing`.
  ///
  /// NOTE: `tracking` is only available on iOS 16+ and macOS 13+.
  func applyStyle<Font: FontProtocol>(_ fontType: FontType<Font>, alignment: TextAlignment) -> some View {
    return applyStyle(fontType)
      .multilineTextAlignment(alignment)
  }
  
  /// Applies `font`, `foregroundColor`, `multilineTextAlignment`, `tracking` and `lineSpacing`.
  ///
  /// NOTE: `tracking` is only available on iOS 16+ and macOS 13+.
  func applyStyle<Font: FontProtocol>(_ fontType: FontType<Font>, color: Color, alignment: TextAlignment) -> some View {
    return applyStyle(fontType, color: color)
      .multilineTextAlignment(alignment)
  }
}

public extension TextField {
  /// Applies `font`, `tracking` and `lineSpacing`.
  ///
  /// NOTE: `tracking` is only available on iOS 16+ and macOS 13+.
  @ViewBuilder
  func applyStyle<Font: FontProtocol>(_ fontType: FontType<Font>) -> some View {
    if #available(macOS 13.0, iOS 16.0, *) {
      self
        .font(fontType.font)
        .lineSpacing(fontType.lineSpacing)
        .tracking(fontType.tracking)
    } else {
      self
        .font(fontType.font)
        .lineSpacing(fontType.lineSpacing)
    }
  }
  
  /// Applies `font`, `foregroundColor`, `tracking` and `lineSpacing`.
  ///
  /// NOTE: `tracking` is only available on iOS 16+ and macOS 13+.
  func applyStyle<Font: FontProtocol>(_ fontType: FontType<Font>, color: Color) -> some View {
    return applyStyle(fontType)
      .foregroundColor(color)
  }
  
  /// Applies `font`, `multilineTextAlignment`, `tracking` and `lineSpacing`.
  ///
  /// NOTE: `tracking` is only available on iOS 16+ and macOS 13+.
  func applyStyle<Font: FontProtocol>(_ fontType: FontType<Font>, alignment: TextAlignment) -> some View {
    return applyStyle(fontType)
      .multilineTextAlignment(alignment)
  }
  
  /// Applies `font`, `foregroundColor`, `multilineTextAlignment`, `tracking` and `lineSpacing`.
  ///
  /// NOTE: `tracking` is only available on iOS 16+ and macOS 13+.
  func applyStyle<Font: FontProtocol>(_ fontType: FontType<Font>, color: Color, alignment: TextAlignment) -> some View {
    return applyStyle(fontType, color: color)
      .multilineTextAlignment(alignment)
  }
}

public extension TextEditor {
  /// Applies `font`, `tracking` and `lineSpacing`.
  ///
  /// NOTE: `tracking` is only available on iOS 16+ and macOS 13+.
  @ViewBuilder
  func applyStyle<Font: FontProtocol>(_ fontType: FontType<Font>) -> some View {
    if #available(macOS 13.0, iOS 16.0, *) {
      self
        .font(fontType.font)
        .tracking(fontType.tracking)
        .lineSpacing(fontType.lineSpacing)
    } else {
      self
        .font(fontType.font)
        .lineSpacing(fontType.lineSpacing)
    }
  }
  
  /// Applies `font`, `foregroundColor`, `tracking` and `lineSpacing`.
  ///
  /// NOTE: `tracking` is only available on iOS 16+ and macOS 13+.
  func applyStyle<Font: FontProtocol>(_ fontType: FontType<Font>, color: Color) -> some View {
    return applyStyle(fontType)
      .foregroundColor(color)
  }
  
  /// Applies `font`, `multilineTextAlignment`, `tracking` and `lineSpacing`.
  ///
  /// NOTE: `tracking` is only available on iOS 16+ and macOS 13+.
  func applyStyle<Font: FontProtocol>(_ fontType: FontType<Font>, alignment: TextAlignment) -> some View {
    return applyStyle(fontType)
      .multilineTextAlignment(alignment)
  }
  
  /// Applies `font`, `foregroundColor`, `multilineTextAlignment`, `tracking` and `lineSpacing`.
  ///
  /// NOTE: `tracking` is only available on iOS 16+ and macOS 13+.
  func applyStyle<Font: FontProtocol>(_ fontType: FontType<Font>, color: Color, alignment: TextAlignment) -> some View {
    return applyStyle(fontType, color: color)
      .multilineTextAlignment(alignment)
  }
}

public extension View {
  /// Applies `font`, `tracking` and `lineSpacing`.
  ///
  /// NOTE: `tracking` is only available on iOS 16+ and macOS 13+
  @_disfavoredOverload
  @ViewBuilder
  func applyStyle<Font: FontProtocol>(_ fontType: FontType<Font>) -> some View {
    if #available(macOS 13.0, iOS 16.0, *) {
      self
        .font(fontType.font)
        .tracking(fontType.tracking)
    } else {
      self.font(fontType.font)
        .lineSpacing(fontType.lineSpacing)
    }
  }
  
  /// Applies `font`, `foregroundColor`, `tracking` and `lineSpacing`.
  ///
  /// NOTE: `tracking` is only available on iOS 16+ and macOS 13+.
  @_disfavoredOverload
  func applyStyle<Font: FontProtocol>(_ fontType: FontType<Font>, color: Color) -> some View {
    return applyStyle(fontType)
      .foregroundColor(color)
  }
  
  /// Applies `font`, `multilineTextAlignment`, `tracking` and `lineSpacing`.
  ///
  /// NOTE: `tracking` is only available on iOS 16+ and macOS 13+.
  @_disfavoredOverload
  func applyStyle<Font: FontProtocol>(_ fontType: FontType<Font>, alignment: TextAlignment) -> some View {
    return applyStyle(fontType)
      .multilineTextAlignment(alignment)
  }
  
  /// Applies `font`, `foregroundColor`, `multilineTextAlignment`, `tracking` and `lineSpacing`.
  ///
  /// NOTE: `tracking` is only available on iOS 16+ and macOS 13+.
  @_disfavoredOverload
  func applyStyle<Font: FontProtocol>(
    _ fontType: FontType<Font>,
    color: Color,
    alignment: TextAlignment) -> some View {
      return applyStyle(fontType, color: color)
        .multilineTextAlignment(alignment)
    }
}
