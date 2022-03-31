//
//  ContentView.swift
//  darkMode
//
//  Created by Chanwoo Cho on 2022/03/31.
//

import SwiftUI

struct SecondView: View {
  @Environment(\.colorScheme) var scheme
  
  var body: some View {
    ZStack {
      Theme.backgroundColor(scheme: scheme)
        .edgesIgnoringSafeArea(.all)
      
      Text("Green's DarkMode")
        .padding()
    }
  }
}
