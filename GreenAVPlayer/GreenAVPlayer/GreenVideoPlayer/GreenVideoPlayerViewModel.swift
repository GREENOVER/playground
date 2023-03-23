//
//  GreenVideoPlayerViewModel.swift
//  GreenAVPlayer
//
//  Created by GREEN on 2023/03/23.
//

import AVKit
import Combine

final public class GreenVideoPlayerViewModel: ObservableObject {
  @Published var pipStatus: PipStatus = .unowned
  @Published var media: Media?
  
  let player = AVPlayer()
  private var cancellable: AnyCancellable?
  
  public init() {
    setAudioSessionCategory(to: .playback)
    cancellable = $media
      .compactMap({ $0 })
      .compactMap({ URL(string: $0.url) })
      .sink(receiveValue: { [weak self] in
        guard let self = self else { return }
        self.player.replaceCurrentItem(with: AVPlayerItem(url: $0))
      })
  }
  
  // 영상 재생
  func play() {
    player.play()
  }
  
  // 영상 정지
  func pause() {
    player.pause()
  }
  
  // 영상 음소거
  func mute(_ isMuted: Bool) {
    player.isMuted = isMuted
  }
  
  func setAudioSessionCategory(to value: AVAudioSession.Category) {
    let audioSession = AVAudioSession.sharedInstance()
    do {
      try audioSession.setCategory(value)
    } catch {
      print("Setting category to AVAudioSessionCategoryPlayback failed.")
    }
  }
}

