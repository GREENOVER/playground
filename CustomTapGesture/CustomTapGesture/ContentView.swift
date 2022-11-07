//
//  ContentView.swift
//  CustomTapGesture
//
//  Created by GREEN on 2022/11/07.
//

import SwiftUI

struct ContentView: View {
  @State private var location: CGPoint = .zero
  
  var body: some View {
    VStack(spacing: 20) {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundColor(.accentColor)
        .onCustomTapGesture { location in
          self.location = location
        }
      
      Text("Get position of Tap Gesture")
        .onCustomTapGesture { location in
          self.location = location
        }
      
      Circle()
        .fill(self.location.y > 350 ? Color.blue : Color.red)
        .frame(width: 100, height: 100, alignment: .center)
        .onCustomTapGesture { location in
          self.location = location
        }
      
      Text("current position is \(location.x) \(location.y)")
    }
    .padding()
  }
}
