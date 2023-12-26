import SwiftUI

struct ContentView: View {
  @StateObject private var speechRecognizer = SpeechRecognizer()
  
  var body: some View {
    VStack {
      Text("Speech To Text")
        .font(.title)
        .padding()
      
      TextEditor(text: $speechRecognizer.transcript)
      
      HStack {
        Button(action: {
          speechRecognizer.startTranscribing()
        }) {
          Text("Start")
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        
        Button(action: {
          speechRecognizer.stopTranscribing()
        }) {
          Text("Stop")
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
      }
      .padding()
    }
    .padding()
  }
}
