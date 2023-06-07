//
//  SwiftUI5App.swift
//  SwiftUI5
//
//  Created by GREEN on 2023/06/07.
//

import SwiftUI
import SwiftData

@main
struct SwiftUI5App: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .modelContainer(for: Person.self)
  }
}
