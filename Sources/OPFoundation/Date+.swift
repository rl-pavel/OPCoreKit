import Foundation

// MARK: -  Math

public extension Date {
  /// Advances a particular date component by a specified amount and returns the new date.
  func advancing(_ component: Calendar.Component, by value: Int, calendar: Calendar = .current) -> Date? {
    return calendar.date(byAdding: component, value: value, to: self)
  }
  
  /// Calculates difference of date components compared to another date
  ///
  /// Returns the date components, each showing the difference.
  func difference(
    of components: Calendar.Component...,
    to otherDate: Date,
    calendar: Calendar = .current) -> DateComponents {
      return calendar.dateComponents(Set(components), from: self, to: otherDate)
    }
  
  /// Returns whether the date's component is same as another date.
  ///
  /// `Date().isSame(.day, as: Date())`
  func isSame(_ granularity: Calendar.Component, as other: Date, calendar: Calendar = .current) -> Bool {
    return calendar.compare(self, to: other, toGranularity: granularity) == .orderedSame
  }
  
  /// Returns whether the date's component is within the specified range to the current date.
  ///
  /// `Date().isWithinLast(5, .day)`
  func isWithinLast(_ value: Int, _ component: Calendar.Component, calendar: Calendar = .current) -> Bool {
    guard let comparisonDate = Date().advancing(component, by: -value, calendar: calendar) else {
      return false
    }
    return self >? comparisonDate
  }
  
  /// Returns the count of a specified component to another date.
  ///
  /// `Date().number(of: .day, until: Date())`
  func number(of component: Calendar.Component, until nextDate: Date, in calendar: Calendar = .current) -> Int {
    let number = calendar.dateComponents([component], from: self, to: nextDate)
    return number.value(for: component) ?? 0
  }
}


// MARK: - Formatting

public extension Date {
  /// Formats the date using the specified set of localized date format components.
  ///
  /// `Date().format(with: [.weekdayShort, .hour, .minute]) // "Sat 13:00" or "Sat 1:00 PM", etc.
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
    /// **Central Standard Time** or **CST-06:00** if full name is unavailable.
    case timeZoneFull = "zzzz"
  }
}
