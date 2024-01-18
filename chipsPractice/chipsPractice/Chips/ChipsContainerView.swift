//
//  ChipsContainerView.swift
//  chipsPractice
//
//  Created by GREEN on 2024/01/18.
//

import SwiftUI

public struct ChipsContainerView: View {
  @State var totalHeight: CGFloat
  let verticalSpacing: CGFloat
  let horizontalSpacing: CGFloat
  let items: [ChipsType]
  var sortedItems: [ChipsType] {
    items.sorted(by: { $0.priority < $1.priority })
  }
  
  public init(
    totalHeight: CGFloat = .zero,
    verticalSpacing: CGFloat = 4,
    horizontalSpacing: CGFloat = 4,
    items: [ChipsType]
  ) {
    self.totalHeight = totalHeight
    self.verticalSpacing = verticalSpacing
    self.horizontalSpacing = horizontalSpacing
    self.items = items
  }
  
  public var body: some View {
    var width = CGFloat.zero
    var height = CGFloat.zero
    
    GeometryReader { geomety in
      ZStack(alignment: .topLeading) {
        ForEach(self.sortedItems, id: \.title) { item in
          ChipsView(title: item.title)
          .id(item.title)
          .alignmentGuide(.leading) { view in
            if abs(width - view.width) > geomety.size.width {
              width = 0
              height -= view.height
              height -= verticalSpacing
            }
            let result = width
            
            if item == sortedItems.last {
              width = 0
            } else {
              width -= view.width
              width -= horizontalSpacing
            }
            
            return result
          }
          .alignmentGuide(.top) { _ in
            let result = height
            
            if item == sortedItems.last {
              height = 0
            }
            return result
          }
        }
      }
      .background(
        GeometryReader { geometry in
          Color.clear
            .onAppear {
              self.totalHeight = geometry.size.height
            }
        }
      )
    }
    .frame(height: totalHeight)
  }
}
