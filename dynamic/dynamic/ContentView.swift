//
//  ContentView.swift
//  dynamic
//
//  Created by GREEN on 10/17/24.
//

import SwiftUI

struct DynamicScrollView<Content: View>: View {
  let content: Content
  @State private var contentHeight: CGFloat = .zero
  
  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }
  
  var body: some View {
    GeometryReader { geometry in
      if contentHeight > geometry.size.height {
        ScrollView {
          contentView
        }
      } else {
        contentView
      }
    }
  }
  
  private var contentView: some View {
    content
      .background(
        GeometryReader { geometry in
          Color.clear.preference(
            key: ContentHeightKey.self,
            value: geometry.size.height
          )
        }
      )
      .onPreferenceChange(ContentHeightKey.self) { height in
        self.contentHeight = height
      }
  }
}

struct ContentHeightKey: PreferenceKey {
  static var defaultValue: CGFloat = 0
  
  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value = max(value, nextValue())
  }
}

struct ContentView: View {
  @State var nums: [Int] = [1, 2, 3]
  
  var body: some View {
    VStack {
      Text("START")
        .font(.title)
      
      Spacer()
      
      DynamicScrollView {
        VStack(spacing: 20) {
          ForEach(nums, id: \.self) { i in
            Text("Number \(i)")
              .frame(height: 50)
              .frame(maxWidth: .infinity)
              .background(Color.green.opacity(0.1))
          }
        }
        .padding()
      }
      .padding(.vertical, 20)
      
      Spacer()
      
      Button(
        action: {
          let randomCount = Int.random(in: 1...20)
          nums = Array(1...randomCount)
        },
        label: {
          Text("CHANGE")
            .font(.title)
        }
      )
    }
  }
}
