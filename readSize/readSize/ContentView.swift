//
//  ContentView.swift
//  readSize
//
//  Created by GREEN on 2023/09/27.
//

import SwiftUI
import UIKit

struct ContentView: View {
  @State var isMovedTop: Bool = false
  @State var headerSize: CGSize = .zero
  let color: [Color] = [.red, .blue, .orange, .green, .black, .indigo, .mint]
  
  var body: some View {
    ScrollViewRepresentable(
      isMovedTop: $isMovedTop,
      headerSize: $headerSize
    ) {
      VStack(spacing: 10) {
        Text("This is Top")
          .font(.title)
          .onReadSize {
            headerSize = $0
          }
        
        ForEach(color, id: \.self) { color in
          Rectangle()
            .fill(color)
            .frame(width: 300, height: 300)
        }
        
        Button(
          action: {
            isMovedTop = true
          },
          label: {
            Text("Go to Top")
          }
        )
      }
    }
  }
}

struct ScrollViewRepresentable<Content: View>: UIViewRepresentable {
  @Binding var isMovedTop: Bool
  @Binding var headerSize: CGSize
  private let content: Content
  
  init(
    isMovedTop: Binding<Bool>,
    headerSize: Binding<CGSize>,
    @ViewBuilder content: @escaping () -> Content
  ) {
    _isMovedTop = isMovedTop
    _headerSize = headerSize
    self.content = content()
  }
  
  func makeUIView(context: Context) -> UIScrollView {
    let scrollView = UIScrollView()
    let hostVC = UIHostingController(rootView: self.content)
    hostVC.view.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(hostVC.view)
    
    NSLayoutConstraint.activate([
      hostVC.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      hostVC.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      hostVC.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
      hostVC.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      hostVC.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
    ])
    
    return scrollView
  }
  
  func updateUIView(_ uiView :UIScrollView, context :Context) {
    if isMovedTop {
      uiView.setContentOffset(CGPoint(x: 0, y: headerSize.height), animated: true)
      DispatchQueue.main.async {
        isMovedTop = false
      }
    }
  }
}

extension View {
  @ViewBuilder
  func onReadSize(_ perform: @escaping (CGSize) -> Void) -> some View {
    self.customBackground {
      GeometryReader { geometryProxy in
        Color.clear
          .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
      }
    }
    .onPreferenceChange(SizePreferenceKey.self, perform: perform)
  }
  
  @ViewBuilder
  func customBackground<V: View>(alignment: Alignment = .center, @ViewBuilder content: () -> V) -> some View {
    self.background(alignment: alignment, content: content)
  }
}

struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) { }
}
