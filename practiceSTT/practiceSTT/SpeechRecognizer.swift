import Speech

class SpeechRecognizer: NSObject, ObservableObject, SFSpeechRecognizerDelegate {
  private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))!
  private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
  private var recognitionTask: SFSpeechRecognitionTask?
  private let audioEngine = AVAudioEngine()
  
  @Published var transcript = ""
  private var isTranscribing = false // 음성 인식 진행 중 상태를 추적하는 플래그
  
  override init() {
    super.init()
    self.speechRecognizer.delegate = self
  }
  
  func startTranscribing() {
    guard !isTranscribing else { return } // 이미 인식 중이면 바로 반환
    isTranscribing = true // 인식 시작
    
    // 오디오 엔진이 실행 중이면 중지하고 모든 tap을 제거합니다.
    if audioEngine.isRunning {
      audioEngine.stop()
      audioEngine.inputNode.removeTap(onBus: 0)
    }
    
    // 기존의 recognitionTask가 있다면 취소합니다.
    recognitionTask?.cancel()
    recognitionTask = nil
    
    // 오디오 세션을 활성화합니다.
    let audioSession = AVAudioSession.sharedInstance()
    do {
      try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
      try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
    } catch {
      print("오디오 세션 설정 실패: \(error)")
      isTranscribing = false // 오류 발생 시 인식 중 상태 해제
      return
    }
    
    // 새로운 recognitionRequest를 생성합니다.
    recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    guard let recognitionRequest = recognitionRequest else {
      isTranscribing = false // 오류 발생 시 인식 중 상태 해제
      return
    }
    recognitionRequest.shouldReportPartialResults = true
    
    // recognitionTask를 설정합니다.
    recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { [weak self] result, error in
      guard let strongSelf = self else { return }
      
      var isFinal = false
      
      if let result = result {
        DispatchQueue.main.async {
          strongSelf.transcript = result.bestTranscription.formattedString
        }
        isFinal = result.isFinal
      }
      
      if error != nil || isFinal {
        strongSelf.cleanup()
      }
    }
    
    // 오디오 엔진에 tap을 추가합니다.
    let recordingFormat = audioEngine.inputNode.outputFormat(forBus: 0)
    audioEngine.inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
      recognitionRequest.append(buffer)
    }
    
    // 오디오 엔진을 시작합니다.
    do {
      try audioEngine.start()
    } catch {
      print("오디오 엔진 시작 실패: \(error)")
      cleanup()
    }
  }
  
  func stopTranscribing() {
    recognitionTask?.cancel()
    cleanup()
  }
  
  private func cleanup() {
    if audioEngine.isRunning {
      audioEngine.stop()
      audioEngine.inputNode.removeTap(onBus: 0)
    }
    recognitionRequest?.endAudio()
    recognitionRequest = nil
    recognitionTask = nil
    isTranscribing = false // 인식 중 상태 해제
  }
}
