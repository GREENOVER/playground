//
//  DetailCore.swift
//  TCACoordinatorsPractice
//
//  Created by GREEN on 2022/08/15.
//

import ComposableArchitecture

public struct DetailState: Equatable {
  public var title: Int
  
  public init(title: Int) {
    self.title = title
  }
}

public enum DetailAction {
  case backButtonTapped
}

public struct DetailEnvironment {
}

public let detailReducer = Reducer<DetailState, DetailAction, DetailEnvironment> { state, action, env in
  switch action {
  case .backButtonTapped:
    return .none
  }
}

