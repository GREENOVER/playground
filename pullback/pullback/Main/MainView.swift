//
//  ContentView.swift
//  pullback
//
//  Created by GREEN on 2022/09/19.
//

import ComposableArchitecture
import SwiftUI

struct MainView: View {
  var store: Store<MainState, MainAction>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      VStack(spacing: 30) {
        Text(viewStore.mainTitle)
          .font(.title)
        
        SubView(
          store: store.scope(
            state: \.subState,
            action: MainAction.subAction
          )
        )
      }
    }
  }
}

