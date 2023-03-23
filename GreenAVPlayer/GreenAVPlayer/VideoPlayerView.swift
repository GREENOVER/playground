//
//  ContentView.swift
//  GreenAVPlayer
//
//  Created by GREEN on 2023/03/23.
//

import SwiftUI

public struct VideoPlayerView: View {
  @StateObject var viewModel: VideoPlayerViewModel
  @StateObject private var greenVideoPlayerViewModel = GreenVideoPlayerViewModel()
  
  public var body: some View {
    GreenVideoPlayer(viewModel: greenVideoPlayerViewModel)
      .onAppear {
        greenVideoPlayerViewModel.media = Media(
          url: viewModel.contentURL
        )
      }
      .overlay(
        RetryView(
          title: "This video file could not be played",
          remainingRetries: viewModel.remainingRetries,
          perform: {
            Task {
              let canRetryPlay = await viewModel.retryPlayVideo()
              if canRetryPlay {
                greenVideoPlayerViewModel.play()
              }
            }
          }
        )
        .opacity(viewModel.canPlay ? 0 : 1)
      )
  }
}

// MARK: - 재시도 뷰
private struct RetryView: View {
  var title: String
  var remainingRetries: Int
  var perform: () -> Void
  
  public init(
    title: String,
    remainingRetries: Int,
    perform: @escaping () -> Void
  ) {
    self.title = title
    self.remainingRetries = remainingRetries
    self.perform = perform
  }
  
  public var body: some View {
    VStack(alignment: .center, spacing: 10) {
      Spacer()
      
      Text(title)
        .foregroundColor(.white)
      
      Button(
        action: remainingRetries != 0 ? perform : {},
        label: {
          Text(
            remainingRetries != 0
            ? "Please try again"
            : "Please try again later"
          )
        }
      )
      .padding(.horizontal, 20)
      .padding(.vertical, 10)
      .foregroundColor(.white)
      .background(remainingRetries != 0 ? Color.blue : Color.red)
      .cornerRadius(10)
      .disabled(remainingRetries == 0)
      .padding(.bottom, 300)
    }
  }
}
