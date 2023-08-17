//
//  ContentView2.swift
//  nofitication
//
//  Created by GREEN on 2023/08/17.
//

import SwiftUI

struct ContentView2: View {
  @StateObject var viewModel = ContentViewModel()
  
  var body: some View {
    VStack {
      Text(viewModel.notificationText)
        .font(.title)
      
      Button(
        action: {
          viewModel.sendNotification()
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
  }
}

struct ContentView2_Previews: PreviewProvider {
  static var previews: some View {
    ContentView2()
  }
}
