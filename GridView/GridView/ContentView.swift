//
//  ContentView.swift
//  GridView
//
//  Created by GREEN on 2022/11/24.
//

import SwiftUI

struct ContentView: View {
  let columns = [GridItem(.flexible()), GridItem(.flexible())]
  let rows = [GridItem(.flexible())]
  let colors: [Color] = [.black, .blue, .brown, .cyan, .gray, .indigo, .mint, .yellow, .orange, .purple]
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns) {
        ForEach(colors, id: \.self) { color in
          RoundedRectangle(cornerRadius: 10)
            .frame(width: 150, height: 100)
            .foregroundColor(color)
        }
      }
    }
    .padding()
    
    ScrollView(.horizontal) {
      LazyHGrid(rows: rows) {
        ForEach(colors, id: \.self) { color in
          RoundedRectangle(cornerRadius: 10)
            .frame(width: 50, height: 100)
            .foregroundColor(color)
        }
      }
    }
    .padding()
  }
}
