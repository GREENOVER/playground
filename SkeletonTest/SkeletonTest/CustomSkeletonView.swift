//
//  CustomSkeletonView.swift
//  SkeletonTest
//
//  Created by GREEN on 2022/07/25.
//

import SwiftUI
import SkeletonUI

struct CustomSkeletonView: View {
  @State var colors = [Color]()
  
  var body: some View {
    SkeletonList(with: colors, quantity: 10) { loading, color in
      Text(color?.name)
        .skeleton(with: loading)
        .shape(type: .rectangle)
        .appearance(type: .solid(color: .red, background: .blue))
        .multiline(lines: 3, scales: [1: 0.5])
        .animation(type: .pulse())
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        self.colors = [
          Color(name: "GREEN"),
          Color(name: "RED"),
          Color(name: "BLUE"),
          Color(name: "BLACK")
        ]
      }
    }
  }
}

struct Color: Identifiable {
  let id = UUID()
  let name: String
}
