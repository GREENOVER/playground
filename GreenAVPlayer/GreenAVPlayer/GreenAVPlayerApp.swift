//
//  GreenAVPlayerApp.swift
//  GreenAVPlayer
//
//  Created by GREEN on 2023/03/23.
//

import SwiftUI

@main
struct GreenAVPlayerApp: App {
  var body: some Scene {
    WindowGroup {
      VideoPlayerView(viewModel: .init(contentURL: "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4"))
    }
  }
}
