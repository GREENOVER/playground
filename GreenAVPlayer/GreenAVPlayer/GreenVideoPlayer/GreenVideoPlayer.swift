//
//  GreenVideoPlayer.swift
//  GreenAVPlayer
//
//  Created by GREEN on 2023/03/23.
//

import AVKit
import SwiftUI

public struct GreenVideoPlayer: UIViewControllerRepresentable {
  @ObservedObject var viewModel: GreenVideoPlayerViewModel
  
  /// 영상 재생 관련 컨트롤러 노출 및 동작 여부
  var isDisplayPlaybackControls: Bool
  /// 선형 재생 여부 (선형 재생 시 되감기/넘어가기 동작 불가)
  var isRequireLinearPlayback: Bool
  /// 비디오 화면 리사이징
  var videoGravity: AVLayerVideoGravity
  /// PIP 재생 모드 허용 여부
  var isAllowPIP: Bool
  /// 화면 회전 지원
  var autorotate: Bool
  /// 화면 모드
  var interfaceMode: InterfaceOrientationMode
  /// 외부 디바이스 재생 연동
  var isAllowExternalPlayback: Bool
  
  public init(
    viewModel: GreenVideoPlayerViewModel,
    isDisplayPlaybackControls: Bool = true,
    isRequireLinearPlayback: Bool = false,
    videoGravity: AVLayerVideoGravity = .resizeAspect,
    isAllowPIP: Bool = true,
    autorotate: Bool = true,
    interfaceMode: InterfaceOrientationMode = .all,
    isAllowExternalPlayback: Bool = false
  ) {
    self.viewModel = viewModel
    self.isDisplayPlaybackControls = isDisplayPlaybackControls
    self.isRequireLinearPlayback = isRequireLinearPlayback
    self.videoGravity = videoGravity
    self.isAllowPIP = isAllowPIP
    self.autorotate = autorotate
    self.interfaceMode = interfaceMode
    self.isAllowExternalPlayback = isAllowExternalPlayback
  }
  
  public func makeUIViewController(context: Context) -> AVPlayerViewController {
    let controller = CustomAVPlayerViewController(
      autorotate: autorotate,
      interfaceMode: interfaceMode
    )
    
    controller.player = viewModel.player
    controller.delegate = context.coordinator
    controller.showsPlaybackControls = isDisplayPlaybackControls
    controller.requiresLinearPlayback = isRequireLinearPlayback
    controller.videoGravity = videoGravity
    controller.allowsPictureInPicturePlayback = isAllowPIP
    controller.player?.allowsExternalPlayback = isAllowExternalPlayback
   
    return controller
  }
  
  public func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
    uiViewController.player = viewModel.player
    uiViewController.allowsPictureInPicturePlayback = isAllowPIP
  }
  
  public func makeCoordinator() -> Coordinator {
    return Coordinator(self)
  }
  
  public class Coordinator: NSObject, AVPlayerViewControllerDelegate {
    let parent: GreenVideoPlayer
    
    public init(_ parent: GreenVideoPlayer) {
      self.parent = parent
    }
    
    public func playerViewControllerWillStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
      parent.viewModel.pipStatus = .willStart
    }
    
    public func playerViewControllerDidStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
      parent.viewModel.pipStatus = .didStart
    }
    
    public func playerViewControllerWillStopPictureInPicture(_ playerViewController: AVPlayerViewController) {
      parent.viewModel.pipStatus = .willStop
    }
    
    public func playerViewControllerDidStopPictureInPicture(_ playerViewController: AVPlayerViewController) {
      parent.viewModel.pipStatus = .didStop
    }
  }
}

// MARK: - 화면 모드
public enum InterfaceOrientationMode {
  case portrait
  case all
}

// MARK: - 커스텀 AVPlayerController
class CustomAVPlayerViewController: AVPlayerViewController {
  var autorotate: Bool
  var interfaceMode: InterfaceOrientationMode
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(
    autorotate: Bool = true,
    interfaceMode: InterfaceOrientationMode = .all
  ) {
    self.autorotate = autorotate
    self.interfaceMode = interfaceMode
    
    super.init(nibName: nil, bundle: nil)
  }
  
  // 회전 지원
  override var shouldAutorotate: Bool {
    return autorotate
  }
  
  // 세로, 전체 모드
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return interfaceMode == .portrait ? .portrait : .all
  }
}

