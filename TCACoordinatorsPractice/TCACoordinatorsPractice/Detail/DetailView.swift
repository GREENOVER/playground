//
//  DetailState.swift
//  TCACoordinatorsPractice
//
//  Created by GREEN on 2022/08/15.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

public struct DetailView: View {
  var store: Store<DetailState, DetailAction>
  
  public var body: some View {
    WithViewStore(store) { viewStore in
      Text("\(viewStore.title)")
      Button(
        action: { ViewStore(store).send(.backButtonTapped) },
        label: { Text("Go back to list view") }
      )
    }
    .navigationBarHidden(true)
  }
}
