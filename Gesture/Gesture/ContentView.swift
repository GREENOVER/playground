//
//  ContentView.swift
//  Gesture
//
//  Created by Chanwoo Cho on 2021/12/02.
//

import SwiftUI

struct HangOnDogeView: View {
  @State private var dragLocation: CGPoint?
  @State private var isChangedImage: Bool = true
  private var image: String {
    isChangedImage ? "Doge" : "Rocket"
  }
  
  var body: some View {
    GeometryReader { geo in
      Image(image)
        .frame(width: 50, height: 50)
        .position(
          self.dragLocation ?? CGPoint(
            x: 100,
            y: geo.size.height - 100
          )
        )
        .gesture(
          TapGesture()
            .onEnded({
              isChangedImage.toggle()
            })
        )
        .highPriorityGesture(
          DragGesture()
            .onChanged ({
              self.dragLocation = $0.location
              isChangedImage.toggle()
            })
            .onEnded({ _ in
              isChangedImage.toggle()
            })
        )
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    HangOnDogeView()
  }
}
