//
//  HomeView.swift
//  TCACoordinatorsPractice
//
//  Created by GREEN on 2022/08/15.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

public struct HomeView: View {
  var store: Store<HomeState, HomeAction>
  
  public var body: some View {
    WithViewStore(store) { viewStore in
      List {
        ForEach(viewStore.nums, id: \.self) { num in
          Button(
            action: {
              ViewStore(store).send(.itemTapped(num))
            },
            label: { Text("\(num)") }
          )
        }
      }
    }
  }
}
