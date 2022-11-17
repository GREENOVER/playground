//
//  CarouselView.swift
//  InfiniteCarousel
//
//  Created by GREEN on 2022/11/17.
//

import ComposableArchitecture
import SwiftUI

public struct InfiniteCarouselView: View {
  let store: Store<CarouselState, CarouselAction>
  
  public var body: some View {
    WithViewStore(store) { viewStore in
      TabView(
        selection: .init(
          get: { viewStore.state.index },
          set: { viewStore.send(.setIndex($0)) }
        )
      ) {
        ForEach(viewStore.state.tabs, id: \.hashValue) { tab in
          VStack {
            Spacer()
            
            Text(tab.title)
              .font(.largeTitle)
            
            Spacer()
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background(tab.bgColor)
          .tag(
            getIndex(
              tabs: viewStore.state.tabs,
              tab: tab
            )
          )
        }
      }
      .tabViewStyle(.page(indexDisplayMode: .never))
      .frame(height: 300)
      .onAppear {
        viewStore.send(.onAppear)
      }
      .onChange(of: viewStore.state.index) { _ in
        viewStore.send(.onChange)
      }
      .animation(.easeInOut, value: UUID())
      .simultaneousGesture(
        DragGesture()
          .onChanged { _ in
            viewStore.send(.startUserScroll)
          }
      )
    }
  }
}
