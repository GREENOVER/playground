//
//  SubView.swift
//  pullback
//
//  Created by GREEN on 2022/09/19.
//

import ComposableArchitecture
import SwiftUI

struct SubView: View {
  var store: Store<SubState, SubAction>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      VStack(spacing: 20) {
        Text(viewStore.subTitle)
          .font(.body)
        
        Button(
          action: { viewStore.send(.changeTitleButtonTapped) },
          label: { Text("Click for Change title") }
        )
      }
    }
  }
}
