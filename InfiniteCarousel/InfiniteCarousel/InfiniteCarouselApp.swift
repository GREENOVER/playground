//
//  InfiniteCarouselApp.swift
//  InfiniteCarousel
//
//  Created by GREEN on 2022/11/17.
//

import SwiftUI

@main
struct InfiniteCarouselApp: App {
  var body: some Scene {
    WindowGroup {
      MainView(
        store: .init(
          initialState: .init(),
          reducer: mainReducer,
          environment: .init(mainQueue: .main)
        )
      )
    }
  }
}
