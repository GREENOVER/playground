//
//  CustomTabView.swift
//  CustomTabView
//
//  Created by GREEN on 2023/07/03.
//

import SwiftUI

public protocol TabTitleConvertible {
  var title: String { get }
}

public struct CustomTabView<Selection>: View where Selection: Hashable & Identifiable & Comparable & TabTitleConvertible {
  public var views: [Selection: AnyView]
  @Binding public var selection: Selection
  @State private var barXOffset: CGFloat = 0
  @State private var barIsActive = false
  private var count: Int {
    views.count
  }
  
  public init(
    views: [Selection: AnyView],
    selection: Binding<Selection>
  ) {
    self.views = views
    self._selection = selection
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      GeometryReader { geometry in
        let tabSize = geometry.size.width / CGFloat(count)
        VStack(spacing: 0) {
          HStack(spacing: 0) {
            ForEach(
              views.keys.sorted(),
              content: { key in
                Button(
                  action: { selection = key },
                  label: {
                    HStack(spacing: 0) {
                      Spacer()
                      
                      Text(key.title)
                        .font(.title)
                        .foregroundColor(.black)
                      
                      Spacer()
                    }
                  }
                )
                .frame(width: tabSize)
              }
            )
          }
          .padding(.vertical, 15)
          .frame(height: 53)
          
          ZStack(alignment: .bottom) {
            Rectangle()
              .fill(.gray)
              .frame(height: 1)
            
            HStack {
              Rectangle()
                .fill(Color.black)
                .frame(width: tabSize, height: 3)
                .offset(x: barXOffset)
//                .animation(barIsActive ? .linear(duration: 0.25) : .none, value: barXOffset)
                .animation(.linear(duration: 0.25))
              
              Spacer()
            }
          }
        }
        .onAppear {
          let selectedIndex = CGFloat((selection.id as? Int ?? 0))
          barXOffset = selectedIndex * tabSize
          
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            barIsActive = true
          }
        }
        .onChange(of: selection, perform: { newValue in
          let selectedIndex = CGFloat((newValue.id as? Int ?? 0))
          barXOffset = selectedIndex * tabSize
        })
      }
      .frame(height: 56)
      
      if let view = views[selection] {
        view
      } else {
        EmptyView()
      }
    }
  }
}

