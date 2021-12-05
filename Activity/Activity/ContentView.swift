//
//  ContentView.swift
//  activity
//
//  Created by Chanwoo Cho on 2021/11/29.
//

import SwiftUI

public struct ActivityView: UIViewControllerRepresentable {
  @Binding var isPresented: Bool
  public let activityItmes: [Any]
  public let applicationActivities: [UIActivity]? = nil
  
  public func makeUIViewController(context: Context) -> UIViewController {
    UIViewController()
  }
  
  public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    let activityViewController = UIActivityViewController(
      activityItems: activityItmes,
      applicationActivities: applicationActivities
    )

    if isPresented && uiViewController.presentedViewController == nil {
      uiViewController.present(activityViewController, animated: true)
    }
    activityViewController.completionWithItemsHandler = { (_, _, _, _) in
      isPresented = false
    }
  }
}

struct ContentView: View {
  @State private var isActivityViewPresented = false
  
  var body: some View {
    Button("Share Link") {
      self.isActivityViewPresented = true
    }
    .background(
      ActivityView(
        isPresented: $isActivityViewPresented,
        activityItmes: [URL(string: "https://green1229.tistory.com")!, "green is green"]
      )
    )
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
