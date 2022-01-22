import Foundation

public extension Date {
  func advancing(_ component: Calendar.Component, by value: Int, calendar: Calendar = Calendar.current) -> Date? {
    return calendar.date(byAdding: component, value: value, to: self)
  }
  
  func difference(
    of components: Calendar.Component...,
    to otherDate: Date,
    calendar: Calendar = Calendar.current) -> DateComponents {
      return calendar.dateComponents(Set(components), from: self, to: otherDate)
    }
  
  func isSame(_ granularity: Calendar.Component, as other: Date, calendar: Calendar = Calendar.current) -> Bool {
    return calendar.compare(self, to: other, toGranularity: granularity) == .orderedSame
  }
  
  func isWithinLast(_ value: Int, _ component: Calendar.Component, calendar: Calendar = .current) -> Bool {
    guard let comparisonDate = Date().advancing(component, by: -value, calendar: calendar) else {
      return false
    }
    return self >? comparisonDate
  }
  
  func number(of component: Calendar.Component, until nextDate: Date, in calendar: Calendar = .current) -> Int {
    let number = calendar.dateComponents([component], from: self, to: nextDate)
    return number.value(for: component) ?? 0
  }
  
  
  // MARK: - Formatting
  
  /// - Sun, 12:00 AM
  /// - Sun, Jun 24, 12:00 AM
  /// - Sun, Jun 24, 2020, 12:00 AM
  func compactShortDateTimeString(in timeZone: TimeZone = .current, now: Date = .init()) -> String? {
    guard isSame(.year, as: now) && self > now else {
      return format(with: [.weekdayShort, .monthShort, .dayOfMonth, .yearFull, .hour, .minute])
    }
    
    guard isSame(.weekOfMonth, as: now) && self > now else {
      return format(with: [.weekdayShort, .monthShort, .dayOfMonth, .hour, .minute])
    }
    
    return format(with: [.weekdayShort, .hour, .minute])
  }
}


// MARK: - Helpers

private extension Date {
  func format(
    with components: [DateFormatComponents],
    in timeZone: TimeZone? = .current,
    locale: Locale = .current) -> String? {
      let template = components.map(\.rawValue).joined(separator: " ")
      
      guard let localizedFormat = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: locale) else {
        return nil
      }
      
      let dateFormatter = DateFormatter()
      dateFormatter.timeZone = timeZone
      dateFormatter.dateFormat = localizedFormat
      dateFormatter.locale = locale
      
      return dateFormatter.string(from: self)
    }
  
  
  enum DateFormatComponents: String {
    /// 1997
    case yearFull = "yyyy"
    /// 97 (1997)
    case yearShort = "yy"
    
    /// 7
    case monthDigit = "M"
    /// 07
    case monthDigitPadded = "MM"
    /// Jul
    case monthShort = "MMM"
    /// July
    case monthFull = "MMMM"
    /// J (July)
    case monthLetter = "MMMMM"
    
    /// 5
    case dayOfMonth = "d"
    
    /// Sat
    case weekdayShort = "EEE"
    /// Saturday
    case weekdayFull = "EEEE"
    /// S (Saturday)
    case weekdayLetter = "EEEEE"
    
    /// Localized **13** or **1 PM**, depending on the locale.
    case hour = "j"
    /// 20
    case minute = "m"
    /// 08
    case second = "ss"
    
    /// CST
    case timeZone = "zzz"
    /// **Central Standard Time** or **CST-06:00** or if full name is unavailable.
    case timeZoneFull = "zzzz"
  }
}
