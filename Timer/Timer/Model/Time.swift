//
//  Time.swift
//  Timer
//
//  Created by GREEN on 2023/08/22.
//

import Foundation

struct Time {
  var hours: Int
  var minutes: Int
  var seconds: Int
  
  var convertedSeconds: Int {
    return (hours * 3600) + (minutes * 60) + seconds
  }
  
  static func fromSeconds(_ seconds: Int) -> Time {
    let hours = seconds / 3600
    let minutes = (seconds % 3600) / 60
    let remainingSeconds = (seconds % 3600) % 60
    return Time(hours: hours, minutes: minutes, seconds: remainingSeconds)
  }
}

extension Int {
  var formattedTimeString: String {
    let time = Time.fromSeconds(self)
    let hoursString = String(format: "%02d", time.hours)
    let minutesString = String(format: "%02d", time.minutes)
    let secondsString = String(format: "%02d", time.seconds)
    
    return "\(hoursString) : \(minutesString) : \(secondsString)"
  }
  
  var formattedSettingTime: String {
    let currentDate = Date()
    let settingDate = currentDate.addingTimeInterval(TimeInterval(self))
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ko_KR")
    dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
    dateFormatter.dateFormat = "HH:mm"
    
    let formattedTime = dateFormatter.string(from: settingDate)
    return formattedTime
  }
}
