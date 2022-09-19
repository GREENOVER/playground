//
//  pullbackApp.swift
//  pullback
//
//  Created by GREEN on 2022/09/19.
//

import SwiftUI

@main
struct pullbackApp: App {
  var body: some Scene {
    WindowGroup {
      MainView(
        store: .init(
          initialState: .init(),
          reducer: mainReducer,
          environment: .init()
        )
      )
    }
  }
}
