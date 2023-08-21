//
//  TimerApp.swift
//  Timer
//
//  Created by GREEN on 2023/08/22.
//

import SwiftUI

@main
struct TimerApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  var body: some Scene {
    WindowGroup {
      TimerView()
    }
  }
}
