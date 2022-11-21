//
//  ContentView.swift
//  PinnedScrollableViews
//
//  Created by GREEN on 2022/11/21.
//

import SwiftUI

struct ContentView: View {
  let colors: [Color] = [.red, .green, .yellow, .black, .gray, .blue, .brown, .purple, .orange]
  
  var body: some View {
    VStack {
      TitleView()
      
      ScrollView(showsIndicators: false) {
        ScrollTitleView()
        
        LazyVStack(pinnedViews: .sectionHeaders) {
          Section(header: HeaderView()) {
            VStack {
              ForEach(colors, id: \.self) { color in
                CellItemView(color: color)
                  .padding(.horizontal, 10)
              }
            }
          }
        }
      }
    }
  }
}

private struct TitleView: View {
  fileprivate var body: some View {
    Text("Variant Colors")
      .font(.largeTitle)
      .bold()
  }
}

private struct ScrollTitleView: View {
  fileprivate var body: some View {
    Text("ScrollView Start Point")
      .font(.largeTitle)
      .bold()
  }
}

private struct HeaderView: View {
  fileprivate var body: some View {
    HStack {
      Spacer()
      Text("This is Header")
        .font(.title)
        .bold()
        .foregroundColor(.blue)
      Spacer()
    }
    .background(.white)
  }
}

private struct CellItemView: View {
  private var color: Color
  
  fileprivate init(color: Color) {
    self.color = color
  }
  
  fileprivate var body: some View {
    RoundedRectangle(cornerRadius: 20)
      .foregroundColor(color)
      .frame(height: 100)
  }
}
