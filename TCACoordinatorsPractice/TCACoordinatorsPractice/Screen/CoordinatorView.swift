//
//  CoordinatorView.swift
//  TCACoordinatorsPractice
//
//  Created by GREEN on 2022/08/15.
//

import ComposableArchitecture
import SwiftUI
import TCACoordinators

public struct CoordinatorView: View {
  let store: Store<CoordinatorState, CoordinatorAction>
  
  public var body: some View {
    TCARouter(store) { screen in
      SwitchStore(screen) {
        CaseLet(
          state: /ScreenState.home,
          action: ScreenAction.home,
          then: HomeView.init
        )
        CaseLet(
          state: /ScreenState.detail,
          action: ScreenAction.detail,
          then: DetailView.init
        )
      }
    }
  }
}
