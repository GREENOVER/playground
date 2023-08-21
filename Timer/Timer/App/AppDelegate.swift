//
//  AppDelegate.swift
//  Timer
//
//  Created by GREEN on 2023/08/22.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
  var notifDelegate = NotificationDelegate()
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
  ) -> Bool {
    UNUserNotificationCenter.current().delegate = notifDelegate
    return true
  }
}
