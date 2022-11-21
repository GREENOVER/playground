//
//  CarouselCore.swift
//  InfiniteCarousel
//
//  Created by GREEN on 2022/11/17.
//

import Foundation
import ComposableArchitecture

struct CarouselState: Equatable {
  public var tabs: [Tab]
  public var index: Int
  
  public var cindex: Int = 0
  
  init(
    tabs: [Tab],
    index: Int = 0
  ) {
    self.tabs = tabs
    self.index = index
  }
}

enum CarouselAction: Equatable {
  case onAppear
  case onChange
  
  case setIndex(Int)
  case nextIndex
  case incrementIndex
  
  case startUserScroll
  
  case test(Tab)
}

struct CarouselEnvironment {
  var mainQueue: AnySchedulerOf<DispatchQueue>
  
  init(mainQueue: AnySchedulerOf<DispatchQueue>) {
    self.mainQueue = mainQueue
  }
}

let carouselReducer = Reducer<CarouselState, CarouselAction, CarouselEnvironment> { state, action, env in
  struct TimeID: Hashable { }
  
  switch action {
  case .onAppear:
    guard var first = state.tabs.first,
          var last = state.tabs.last
    else {
      return .none
    }
    state.tabs.append(first)
    
    return Effect.concatenate([
      Effect(value: .setIndex(0)),
      Effect(value: .nextIndex),
    ])
    
  case .onChange:
    if state.index == state.tabs.count {
      return Effect(value: .setIndex(0))
    }
    return .none
    
  case let .setIndex(index):
    state.index = index
    return .none
    
  case .nextIndex:
    return Effect.timer(id: TimeID(), every: 1.0, on: env.mainQueue)
      .map { _ in .incrementIndex }
    
  case .incrementIndex:
    if state.index >= state.tabs.count - 1 {
      state.index = 0
    } else {
      state.index += 1
    }
    return .none
    
  case .startUserScroll:
    return .merge([
      Effect.cancel(id: TimeID()),
      Effect(value: .nextIndex)
        .delay(for: 1, scheduler: env.mainQueue)
        .eraseToEffect(),
    ])
    
  case let .test(tab):
    let index = state.tabs.firstIndex { currentTab in
      return currentTab.title == tab.title
    } ?? 0
    state.cindex = index
    
    return .none
  }
}

func getIndex(
  tabs: [Tab],
  tab: Tab
) -> Int {
  let index = tabs.firstIndex { currentTab in
    return currentTab.title == tab.title
  } ?? 0
  return index
}
