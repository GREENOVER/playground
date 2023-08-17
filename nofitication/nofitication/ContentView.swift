//
//  ContentView.swift
//  nofitication
//
//  Created by GREEN on 2023/08/17.
//

import SwiftUI

struct ContentView: View {
  @State private var notificationText: String = ""
  
  var body: some View {
    VStack {
      Text(notificationText)
        .font(.title)
      
      Button(
        action: {
          sendNotification()
        },
        label: {
          Text("🚀 노티피케이션 발송 🚀")
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8.0)
        }
      )
    }
    .onReceive(NotificationCenter.default.publisher(for: .greenNotification)) { notification in
      if let text = notification.userInfo?["text"] as? String {
        self.notificationText = text
      }
    }
  }
  
  private func sendNotification() {
    NotificationCenter.default.post(
      name: .greenNotification,
      object: nil,
      userInfo: ["text": "🎉 발송 완료 \(Int.random(in: 1...10)) 🎉"]
    )
  }
}

extension Notification.Name {
  static let greenNotification = Notification.Name("greenNotification")
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
