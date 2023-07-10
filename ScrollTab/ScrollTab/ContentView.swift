//
//  ContentView.swift
//  ScrollTab
//
//  Created by GREEN on 2023/07/10.
//

import SwiftUI

struct ContentView: View {
  @StateObject private var viewModel = ContentViewModel()
  
  var body: some View {
    CustomScrollTabView(
      views: [
        .one: AnyView(ChildView(color: .red)),
        .two: AnyView(ChildView(color: .blue)),
        .three: AnyView(ChildView(color: .yellow)),
        .four: AnyView(ChildView(color: .gray)),
        .five: AnyView(ChildView(color: .orange)),
        .six: AnyView(ChildView(color: .brown)),
        .seven: AnyView(ChildView(color: .cyan)),
        .eight: AnyView(ChildView(color: .indigo)),
      ],
      selection: $viewModel.selectedTab
    )
  }
}

// MARK: - 하위 탭 컨텐츠 뷰
private struct ChildView: View {
  var color: Color
  
  fileprivate var body: some View {
    color
      .frame(height: 300)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
