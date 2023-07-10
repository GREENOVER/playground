//
//  ContentView.swift
//  CustomTabView
//
//  Created by GREEN on 2023/07/03.
//

import SwiftUI

struct ContentView: View {
  @StateObject private var viewModel = ContentViewModel()
  
  var body: some View {
    CustomTabView(
      views: [
        .one: AnyView(BlueView()),
        .two:  AnyView(RedView()),
        .three:  AnyView(YellowView())
      ],
      selection: $viewModel.selectedTab
    )
  }
}

// MARK: - 하위 탭 컨텐츠 뷰
private struct BlueView: View {
  fileprivate init() { }
  
  fileprivate var body: some View {
    Color.blue
  }
}

private struct RedView: View {
  fileprivate init() { }
  
  fileprivate var body: some View {
    Color.red
  }
}

private struct YellowView: View {
  fileprivate init() { }
  
  fileprivate var body: some View {
    Color.yellow
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
