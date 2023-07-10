//
//  CustomScrollTabView.swift
//  ScrollTab
//
//  Created by GREEN on 2023/07/10.
//

import SwiftUI

public protocol TabTitleConvertible {
  var title: String { get }
}

public struct CustomScrollTabView<Selection>: View where Selection: Hashable & Identifiable & Comparable & TabTitleConvertible {
  public var views: [Selection: AnyView]
  @Binding public var selection: Selection
  @State private var barXOffset: CGFloat = 0
  @State private var barIsActive = false
  @State private var viewOffset: CGFloat = 0
  
  public init(
    views: [Selection: AnyView],
    selection: Binding<Selection>
  ) {
    self.views = views
    self._selection = selection
  }
  
  public var body: some View {
    LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
      Section(
        header:
          GeometryReader { geometry in
            ZStack {
              ScrollViewReader { scrollProxy in
                ScrollView(.horizontal, showsIndicators: false) {
                  LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    Section(
                      header:
                        VStack(spacing: 0) {
                          HStack(spacing: 0) {
                            ForEach(
                              views.keys.sorted(),
                              content: { key in
                                Button(
                                  action: {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                      selection = key
                                    }
                                  },
                                  label: {
                                    HStack(spacing: 0) {
                                      Spacer()
                                      Text(key.title)
                                      
                                      Spacer()
                                    }
                                    .id(key)
                                  }
                                )
                                .frame(width: 76)
                                .background(GeometryReader { geometry in
                                  Color.clear.onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                      if key == selection {
                                        barXOffset = geometry.frame(in: .named("barSpace")).minX
                                      }
                                    }
                                  }
                                })
                              }
                            )
                          }
                          .padding(.vertical, 15)
                          .frame(height: 53)
                          .coordinateSpace(name: "barSpace")
                          
                          ZStack(alignment: .bottom) {
                            Rectangle()
                              .fill(.gray)
                              .frame(height: 1)
                            
                            HStack {
                              Rectangle()
                                .fill(Color.black)
                                .frame(width: 76, height: 3)
                                .offset(x: barXOffset)
                                .animation(barIsActive ? .linear(duration: 0.25) : .none, value: barXOffset)
                              
                              Spacer()
                            }
                          }
                        }
                    ) {
                    }
                  }
                }
                .onAppear {
                  let selectedIndex = CGFloat((selection.id as? Int ?? 0))
                  barXOffset = selectedIndex * 76
                  
                  DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    barIsActive = true
                  }
                }
                .onChange(of: viewOffset, perform: { newValue in
                  let percentMoved = -newValue / UIScreen.main.bounds.width
                  let currentTabIndex = CGFloat((selection.id as? Int ?? 0))
                  barXOffset = (currentTabIndex + percentMoved) * 76
                })
                .onChange(of: selection, perform: { newValue in
                  DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    let selectedIndex = CGFloat((newValue.id as? Int ?? 0))
                    barXOffset = selectedIndex * 76
                    withAnimation {
                      scrollProxy.scrollTo(newValue, anchor: .trailing)
                    }
                  }
                })
              }
              
              HorizontalGradationView()
            }
          }
        
          .frame(height: 56)
          .background(Color.white)
      ) {
        ZStack {
          if let previousIndex = views.keys.sorted().firstIndex(of: selection), previousIndex > 0,
             let previousView = views[views.keys.sorted()[previousIndex - 1]] {
            previousView
              .animation(.none)
              .edgesIgnoringSafeArea(.bottom)
              .offset(x: -UIScreen.main.bounds.width + viewOffset, y: 0)
              .gesture(
                DragGesture()
                  .onChanged(onDragChanged(drag:))
                  .onEnded(onDragEnded(drag:))
              )
          }
          
          if let view = views[selection] {
            view
              .animation(.none)
              .edgesIgnoringSafeArea(.bottom)
              .offset(x: viewOffset, y: 0)
              .gesture(
                DragGesture()
                  .onChanged(onDragChanged(drag:))
                  .onEnded(onDragEnded(drag:))
              )
          }
          
          if let nextIndex = views.keys.sorted().firstIndex(of: selection), nextIndex < views.keys.sorted().count - 1,
             let nextView = views[views.keys.sorted()[nextIndex + 1]] {
            nextView
              .animation(.none)
              .edgesIgnoringSafeArea(.bottom)
              .offset(x: UIScreen.main.bounds.width + viewOffset, y: 0)
              .gesture(
                DragGesture()
                  .onChanged(onDragChanged(drag:))
                  .onEnded(onDragEnded(drag:))
              )
          }
        }
      }
    }
  }
  
  private func onDragChanged(drag: DragGesture.Value) {
    if (views.keys.sorted().first != selection || drag.translation.width < 0) &&
        (views.keys.sorted().last != selection || drag.translation.width > 0) {
      viewOffset = drag.translation.width
    }
  }
  
  private func onDragEnded(drag: DragGesture.Value) {
    if viewOffset > UIScreen.main.bounds.width * 0.5 {
      if let previousIndex = views.keys.sorted().firstIndex(of: selection), previousIndex > 0 {
        selection = views.keys.sorted()[previousIndex - 1]
      }
    } else if viewOffset < -UIScreen.main.bounds.width * 0.5 {
      if let nextIndex = views.keys.sorted().firstIndex(of: selection), nextIndex < views.keys.sorted().count - 1 {
        selection = views.keys.sorted()[nextIndex + 1]
      }
    }
    withAnimation {
      viewOffset = 0
    }
  }
}

// MARK: - 스크롤 시 양 옆 그라데이션 뷰
private struct HorizontalGradationView: View {
  fileprivate var body: some View {
    HStack(spacing: 0) {
      LinearGradient(
        gradient: Gradient(
          colors: [
            .white,
            .white.opacity(0.0)
          ]
        ),
        startPoint: .leading,
        endPoint: .trailing
      )
      .frame(width: 32)
      
      Spacer()
      
      LinearGradient(
        gradient: Gradient(
          colors: [
            .white.opacity(0.0),
            .white
          ]
        ),
        startPoint: .leading,
        endPoint: .trailing
      )
      .frame(width: 32)
    }
    .frame(height: 48)
  }
}
