//
//  MainCore.swift
//  pullback
//
//  Created by GREEN on 2022/09/19.
//

import ComposableArchitecture

struct MainState: Equatable {
  var mainTitle: String = "Is Changed Sub Title?"
  var subState: SubState = .init()
}

enum MainAction {
  case subAction(SubAction)
}

struct MainEnvironment { }

let mainReducer = Reducer.combine([
  subReducer.pullback(
    state: \.subState,
    action: /MainAction.subAction,
    environment: { _ in
      SubEnvironment()
    }
  ) as Reducer<MainState, MainAction, MainEnvironment>,
  Reducer<MainState, MainAction, MainEnvironment> { state, action, env in
    switch action {
    case .subAction(.changeTitleButtonTapped):
      state.mainTitle = "Changed Sub title!"
      return .none
      
    case .subAction:
      return .none
    }
  }
])
  .signpost()
