//
//  ContentView.swift
//  NavigationStack
//
//  Created by GREEN on 2022/06/20.
//

import SwiftUI

struct ContentView: View {
  @State var stack = NavigationPath()
  
  var body: some View {
    NavigationStack(path: $stack) {
      NavigationLink("Go to Child View", value: "10")
        .navigationDestination(for: String.self) { value in
          VStack {
            NavigationLink("Go to Child's Child View", value: "20")
            
            Text("Child Number is \(value)")
            
            Button("Go to Parent View") {
              stack.removeLast()
            }
            
            Button("Go to Root View") {
              stack = .init()
            }
          }
        }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
