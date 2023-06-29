//
//  testApp.swift
//  test
//
//  Created by GREEN on 2023/06/27.
//

import SwiftUI

@main
struct testApp: App {
  var body: some Scene {
    WindowGroup {
      CalenderView(month: Date())
    }
  }
}
