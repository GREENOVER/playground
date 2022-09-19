//
//  SubCore.swift
//  pullback
//
//  Created by Green on 2022/09/19.
//

import ComposableArchitecture

struct SubState: Equatable {
  var subTitle: String = "What's the Sub Title"
}

enum SubAction {
  case changeTitleButtonTapped
}

struct SubEnvironment { }

let subReducer = Reducer<SubState, SubAction, SubEnvironment> { state, action, env in
  switch action {
  case .changeTitleButtonTapped:
    state.subTitle = "Tapped Sub title Button"
    return .none
  }
}
