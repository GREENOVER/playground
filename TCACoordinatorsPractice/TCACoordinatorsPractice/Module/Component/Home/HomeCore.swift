//
//  HomeCore.swift
//  TCACoordinatorsPractice
//
//  Created by GREEN on 2022/08/15.
//

import ComposableArchitecture

public struct HomeState: Equatable {
  public var nums: [Int]
  
  public init(nums: [Int] = Array(1...10)) {
    self.nums = nums
  }
}

public enum HomeAction {
  case itemTapped(Int)
}

public struct HomeEnvironment {
}

public let homeReducer = Reducer<HomeState, HomeAction, HomeEnvironment> { state, action, env in
  switch action {
  case let .itemTapped(num):
    return .none
  }
}
