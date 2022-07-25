//
//  ContentView.swift
//  SkeletonTest
//
//  Created by GREEN on 2022/07/25.
//

import SwiftUI
import SkeletonUI

struct SkeletonView: View {
  @State var colors = [String]()
  
  var body: some View {
    VStack {
      Spacer()
        .frame(height: 350)
      Text("Colors data download is completed")
        .skeleton(with: colors.isEmpty)
      Spacer()
        .frame(height: 350)
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        self.colors = ["GREEN", "RED", "BLUE", "YELLOW", "BLACK"]
      }
    }
  }
}
