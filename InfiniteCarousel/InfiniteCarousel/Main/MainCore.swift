//
//  MainCore.swift
//  InfiniteCarousel
//
//  Created by GREEN on 2022/11/17.
//

import ComposableArchitecture
import Foundation
import SwiftUI

struct MainState: Equatable {
  var tabs: [Tab]
  var carousel: CarouselState
  
  init(
    tabs: [Tab] = [
      Tab(title: "하나면 하나지 둘이겠느냐", bgColor: .green),
      Tab(title: "둘이면 둘이지 셋이겠느냐", bgColor: .red),
      Tab(title: "셋이면 셋이지 넷이겠느냐", bgColor: .blue),
      Tab(title: "넷이면 넷이지 넷이겠느냐", bgColor: .brown),
      Tab(title: "다섯이면 다섯이지 다섯이겠느냐", bgColor: .yellow),
      Tab(title: "여섯이면 여섯이지 여섯이겠느냐", bgColor: .cyan),
    ],
    currentIndex: Int = 0
  ) {
    self.tabs = tabs
    self.carousel = .init(tabs: self.tabs)
  }
}

enum MainAction: Equatable {
  case carousel(CarouselAction)
}

struct MainEnvironment {
  var mainQueue: AnySchedulerOf<DispatchQueue>
  
  init(mainQueue: AnySchedulerOf<DispatchQueue>) {
    self.mainQueue = mainQueue
  }
}

let mainReducer = Reducer.combine([
  carouselReducer
    .pullback(
      state: \.carousel,
      action: /MainAction.carousel,
      environment: {
        CarouselEnvironment(mainQueue: $0.mainQueue)
      }
    ) as Reducer<MainState, MainAction, MainEnvironment>,
  Reducer<MainState, MainAction, MainEnvironment> { state, action, env in
    switch action {
    case .carousel:
      return .none
    }
  }
])
