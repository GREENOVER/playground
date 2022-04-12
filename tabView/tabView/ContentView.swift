//
//  ContentView.swift
//  tabView
//
//  Created by Green on 2022/04/09.
//

import SwiftUI

struct ContentView: View {
  @State private var selection = 2
  
  init() {
    UITabBar.appearance().scrollEdgeAppearance = .init()
    UITabBar.appearance().backgroundColor = .black
  }
  
  var body: some View {
    TabView(selection: $selection) {
      Text("The First Tab")
        .badge(10)
        .tabItem {
          Image(systemName: "1.square.fill")
          Text("홈")
        }
        .tag(1)      Text("Another Tab")
        .badge(20)
        .tabItem {
          Image(systemName: "2.square.fill")
          Text("보관함")
        }
        .tag(2)
    }
    .accentColor(.white)
    .font(.headline)
    .overlay(
      VStack {
        Spacer()
          .frame(height: 740)
        Button(action: {})
            {
                Text("기록")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .lineLimit(0)

            }
            .padding(.all)
            .accentColor(.black)
            .frame(width: 65, height: 65, alignment: .center)
            .background(Color.gray)
            .cornerRadius(50)
        Spacer()
      }
    )
  }
}
