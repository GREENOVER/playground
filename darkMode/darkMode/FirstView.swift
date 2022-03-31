//
//  ContentView.swift
//  darkMode
//
//  Created by Chanwoo Cho on 2022/03/31.
//

import SwiftUI

struct FirstView: View {
  var body: some View {
    ZStack {
      Color("Background")
        .edgesIgnoringSafeArea(.all)
      
      Text("Green's DarkMode")
        .padding()
    }
  }
}
