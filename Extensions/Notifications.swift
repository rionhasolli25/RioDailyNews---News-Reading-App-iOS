//
//  Notifications.swift
//  RionApp.com
//
//  Created by Rion on 4.12.22.
//

import Foundation
import UIKit
extension Notification.Name{
    static var messageSent = Notification.Name.init("messageSent")
}
extension UIViewController{
    func registerNotification(notification name : Notification.Name,selector: Selector){
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }
    func postNotification(notification name : Notification.Name,object : Any?){
        NotificationCenter.default.post(name: name, object: object)
    }
    func postNotification(notification name : Notification.Name,object : Any?,userInfo : [AnyHashable : Any]?){
        NotificationCenter.default.post(name: name, object: object,userInfo: userInfo)
    }
    func removeNotification(){
        NotificationCenter.default.removeObserver(self)
    }
}
extension Calendar{
    
    func dayOfWeek(_ date : Date) -> Int{
        var dayOfWeek = self.component(.weekday, from: date) + 1 - self.firstWeekday
        
        if dayOfWeek >= 0{
            dayOfWeek += 7
        }
        return dayOfWeek
    }
    func startOfMonth(_ date:Date) -> Date{
        return self.date(from: self.dateComponents([.year,.month], from: date))!
    }
    func startOfYear(_ date : Date) -> Date{
        return self.date(from: self.dateComponents([.year], from: date))!
    }
    func startofWeek(_ date : Date) -> Date{
        return self.date(byAdding: DateComponents(day: -self.dayOfWeek(date) + 1), to: date)!
    }
}

extension Date{
    static func today() -> Date{
        return Date()
    }
    func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
      return get(.previous,
                 weekday,
                 considerToday: considerToday)
    }
    
    func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
      return get(.next,
                 weekday,
                 considerToday: considerToday)
    }
    func get(_ direction: SearchDirection,
             _ weekDay: Weekday,
             considerToday consider: Bool = false) -> Date {

      let dayName = weekDay.rawValue

      let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }

      assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")

      let searchWeekdayIndex = weekdaysName.firstIndex(of: dayName)! + 1

      let calendar = Calendar(identifier: .gregorian)

      if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
        return self
      }

      var nextDateComponent = calendar.dateComponents([.hour, .minute, .second], from: self)
      nextDateComponent.weekday = searchWeekdayIndex

      let date = calendar.nextDate(after: self,
                                   matching: nextDateComponent,
                                   matchingPolicy: .nextTime,
                                   direction: direction.calendarSearchDirection)

      return date!
    }

  }


extension Date {
  func getWeekDaysInEnglish() -> [String] {
    var calendar = Calendar(identifier: .gregorian)
    calendar.locale = Locale(identifier: "en_US_POSIX")
    return calendar.weekdaySymbols
  }

  enum Weekday: String {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
  }

  enum SearchDirection {
    case next
    case previous

    var calendarSearchDirection: Calendar.SearchDirection {
      switch self {
      case .next:
        return .forward
      case .previous:
        return .backward
      }
    }
  }
}
enum Weekday: String {
  case monday, tuesday, wednesday, thursday, friday, saturday, sunday
}

extension Date{
    func toString(format : String = "dd/MM/yyyy") -> String{
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
   
}
extension String{
    func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ss")-> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale.current
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
}
