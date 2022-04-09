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
    UITabBar.appearance().backgroundColor = .white
  }
  
  var body: some View {
    TabView(selection: $selection) {
      Text("The First Tab")
        .badge(10)
        .tabItem {
          Image(systemName: "1.square.fill")
          Text("First")
        }
        .tag(1)
      Text("Another Tab")
        .badge(20)
        .tabItem {
          Image(systemName: "2.square.fill")
          Text("Second")
        }
        .tag(2)
      Text("The Last Tab")
        .badge(30)
        .tabItem {
          Image(systemName: "3.square.fill")
          Text("Third")
        }
        .tag(3)
    }
    .accentColor(.green)
    .font(.headline)
  }
}
