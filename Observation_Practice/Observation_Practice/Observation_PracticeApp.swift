//
//  Observation_PracticeApp.swift
//  Observation_Practice
//
//  Created by GREEN on 2023/06/08.
//

import SwiftUI

@main
struct Observation_PracticeApp: App {
  @State var dog: Dog?
  
  var body: some Scene {
    WindowGroup {
      ContentView(dogList: .init(dogs: []))
        .environment(dog)
    }
  }
}
