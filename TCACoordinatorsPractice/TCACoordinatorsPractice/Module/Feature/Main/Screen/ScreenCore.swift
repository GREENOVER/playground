//
//  ScreenState.swift
//  TCACoordinatorsPractice
//
//  Created by GREEN on 2022/08/15.
//

import ComposableArchitecture

public enum ScreenState: Equatable {
  case home(HomeState)
  case detail(DetailState)
}

public enum ScreenAction {
  case home(HomeAction)
  case detail(DetailAction)
}

public struct ScreenEnvironment {
}

public let screenReducer = Reducer<ScreenState, ScreenAction, ScreenEnvironment>.combine([
  homeReducer.pullback(
    state: /ScreenState.home,
    action: /ScreenAction.home,
    environment: { _ in HomeEnvironment() }
  ),
  detailReducer.pullback(
    state: /ScreenState.detail,
    action: /ScreenAction.detail,
    environment: { _ in DetailEnvironment() }
  )
])

