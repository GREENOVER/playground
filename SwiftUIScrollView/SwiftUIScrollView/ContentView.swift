//
//  ContentView.swift
//  SwiftUIScrollView
//
//  Created by GREEN on 2023/06/15.
//

import SwiftUI

struct ContentView: View {
  @Environment(\.horizontalSizeClass) private var sizeClass
  
  var colors: [Color] = [.red, .green, .blue, .yellow]
  
  var body: some View {
    ScrollView(.horizontal) {
      LazyHStack(spacing: 15) {
        ForEach(colors, id: \.self) { color in
          ChildView(color: color)
            .aspectRatio(16.0 / 9.0, contentMode: .fit)
//            .frame(height: 300)
//            .containerRelativeFrame(
//              .horizontal,
//              count: 2,
//              spacing: 10
//            )
            .containerRelativeFrame(
              .horizontal,
              count: sizeClass == .regular ? 2 : 1,
              spacing: 10
            )
        }
      }
      .scrollTargetLayout()
    }
//    .padding(.horizontal, 10)
//    .safeAreaPadding(.horizontal, 10)
    .contentMargins(.horizontal, 10)
//    .scrollTargetBehavior(.paging)
    .scrollTargetBehavior(.viewAligned)
//    .scrollTargetBehavior(GalleryScrollTargetBehavior())
    .scrollIndicators(.hidden)
    .scrollTransition(axis: .horizontal) { content, phase in
      content.scaleEffect(
        x: phase.isIdentity ? 1.0 : 0.8,
        y: phase.isIdentity ? 1.0 : 0.8
      )
      .rotationEffect(.degrees(phase.isIdentity ? 0.0 : 10.0))
      .offset(
        x: phase.isIdentity ? 0 : 20,
        y: phase.isIdentity ? 0 : 20
      )
    }
  }
}

private struct ChildView: View {
  fileprivate var color: Color
  
  fileprivate init(color: Color) {
    self.color = color
  }
  
  fileprivate var body: some View {
    Rectangle()
      .fill(color)
//      .frame(width: 100, height: 100)
  }
}

struct GalleryScrollTargetBehavior: ScrollTargetBehavior {
  func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
    if target.rect.minY < (context.containerSize.height / 3.0),
    context.velocity.dy < 0.0 {
      target.rect.origin.y = 0.0
    }
  }
}

#Preview {
  ContentView()
}
