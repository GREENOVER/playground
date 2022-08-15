//
//  AppView.swift
//  TCACoordinatorsPractice
//
//  Created by GREEN on 2022/08/15.
//

import SwiftUI

struct AppView: View {
  var body: some View {
    CoordinatorView(
      store: .init(
        initialState: .init(),
        reducer: coordinatorReducer,
        environment: CoordinatorEnvironment()
      )
    )
  }
}
