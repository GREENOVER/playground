//
//  ContentView.swift
//  codeScanner
//
//  Created by Chanwoo Cho on 2021/12/07.
//

import SwiftUI
import CodeScanner

struct QRView: View {
  @State private var isShowingScanner = false
  
  var body: some View {
    Button(action: {
      self.isShowingScanner = true
    }) {
      Text("Scan QR Code")
    }
    .sheet(isPresented: $isShowingScanner) {
      CodeScannerView(
        codeTypes: [.qr, .code128, .upce],
        simulatedData: "Some simulated data",
        completion: self.handleScan
      )
    }
  }
  
  private func handleScan(result: Result<String, CodeScannerView.ScanError>) {
    self.isShowingScanner = false
    
    switch result {
    case .success(let data):
      guard let url = URL(string: data) else { return }
      UIApplication.shared.open(url)
    case .failure(let error):
      print("Failed Scan QR Code because of \(error)")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    QRView()
  }
}
