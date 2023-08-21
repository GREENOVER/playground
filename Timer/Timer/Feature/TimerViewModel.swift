//
//  TimerViewModel.swift
//  Timer
//
//  Created by GREEN on 2023/08/22.
//

import Foundation

class TimerViewModel: ObservableObject {
  @Published var isDisplaySetTimeView: Bool
  @Published var time: Time
  @Published var timer: Timer?
  @Published var timeRemaining: Int
  @Published var isPaused: Bool
  var notificationService: NotificationService
  
  init(
    isDisplaySetTimeView: Bool = true,
    time: Time = .init(hours: 0, minutes: 0, seconds: 0),
    timer: Timer? = nil,
    timeRemaining: Int = 0,
    isPaused: Bool = false,
    notificationService: NotificationService = .init()
  ) {
    self.isDisplaySetTimeView = isDisplaySetTimeView
    self.time = time
    self.timer = timer
    self.timeRemaining = timeRemaining
    self.isPaused = isPaused
    self.notificationService = notificationService
  }
}

extension TimerViewModel {
  func settingBtnTapped() {
    isDisplaySetTimeView = false
    timeRemaining = time.convertedSeconds
    startTimer()
  }
  
  func cancelBtnTapped() {
    stopTimer()
    isDisplaySetTimeView = true
  }
  
  func pauseOrRestartBtnTapped() {
    if isPaused {
      startTimer()
    } else {
      timer?.invalidate()
      timer = nil
    }
    isPaused.toggle()
  }
}

private extension TimerViewModel {
  func startTimer() {
    guard timer == nil else { return }
    
    timer = Timer.scheduledTimer(
      withTimeInterval: 1,
      repeats: true
    ) { _ in
      if self.timeRemaining > 0 {
        self.timeRemaining -= 1
      } else {
        self.stopTimer()
        self.notificationService.sendNotification()
      }
    }
  }
  
  func stopTimer() {
    timer?.invalidate()
    timer = nil
  }
}
