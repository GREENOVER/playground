//
//  MainView.swift
//  InfiniteCarousel
//
//  Created by GREEN on 2022/11/17.
//

import ComposableArchitecture
import SwiftUI

struct MainView: View {
  let store: Store<MainState, MainAction>
  let carouselStore: Store<CarouselState, CarouselAction>
  
  init(store: Store<MainState, MainAction>) {
    self.store = store
    self.carouselStore = self.store.scope(
      state: \.carousel,
      action: MainAction.carousel
    )
  }
  
  var body: some View {
    WithViewStore(store) { viewStore in
      InfiniteCarouselView(
        store: carouselStore
      )
      .padding(.horizontal, 20)
    }
  }
}
