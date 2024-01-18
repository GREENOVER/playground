//
//  ContentView.swift
//  chipsPractice
//
//  Created by GREEN on 2024/01/18.
//

import SwiftUI

struct ContentView: View {
  var items: [ChipsType] = [
    .init(title: "첫번째"),
    .init(title: "두번째", priority: 1),
    .init(title: "세번째", priority: 2),
    .init(title: "네번째", priority: 3),
    .init(title: "서른마흔다섯번째", priority: 4),
    .init(title: "여섯번째", priority: 5),
    .init(title: "일곱번째", priority: 6),
    .init(title: "여덟번째", priority: 7),
    .init(title: "아홉번째", priority: 8),
  ]
  
  var body: some View {
    VStack {
      ChipsContainerView(items: items)
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
