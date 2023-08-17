//
//  ContentViewModel.swift
//  nofitication
//
//  Created by GREEN on 2023/08/17.
//

import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
  @Published var notificationText: String
  private var cancellables: Set<AnyCancellable>
  
  init(
    notificationText: String = "",
    cancellables: Set<AnyCancellable> = []
  ) {
    self.notificationText = notificationText
    self.cancellables = cancellables
    bindingNotification()
  }
  
  private func bindingNotification() {
    NotificationCenter.default.publisher(for: .greenNotification)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] notification in
        guard let self = self else { return }
        
        if let userInfo = notification.userInfo,
           let text = userInfo["text"] as? String {
          notificationText = text
        }
      }
      .store(in: &cancellables)
  }
    
  func sendNotification() {
    NotificationCenter.default.post(
      name: .greenNotification,
      object: nil,
      userInfo: ["text": "🎉 발송 완료 \(Int.random(in: 1...10)) 🎉"]
    )
  }
}
