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
          HStack {
            Spacer()
            VStack {
              Spacer()
              
              Text(tab.title)
                .font(.largeTitle)
              
              Spacer()
            }
            Spacer()
          }
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
      .aspectRatio(CGSize(width: 3, height: 1), contentMode: .fit)
      .frame(minHeight: 120)
//      .frame(maxWidth: .infinity, maxHeight: .infinity)
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
