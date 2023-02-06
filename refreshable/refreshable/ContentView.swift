//
//  ContentView.swift
//  refreshable
//
//  Created by GREEN on 2022/12/08.
//

import SwiftUI

struct ContentView: View {
  @State var colors: [Color] = []
  
  var body: some View {
    VStack(spacing: 10) {
      Text("Colors")
        .font(.largeTitle)
        .padding(.top, 50)
      
//      List(colors, id: \.self) { color in
        RoundedRectangle(cornerRadius: 10)
          .frame(width: 300, height: 50)
          .foregroundColor(colors.first)
//      }
      .onAppear {
        colors = initColors()
      }
      .refreshable {
        await colors.append(contentsOf: addColors())
      }
      
      CustomRefresher()
        .refreshable {
          await colors = addColors()
        }
      
      Spacer()
    }
  }
  
  private func initColors() -> [Color] {
    return [.yellow, .green, .indigo, .orange, .purple]
  }
  
  private func addColors() async -> [Color] {
    return [.red, .blue, .gray]
  }
}

struct CustomRefresher: View {
  @Environment(\.refresh) private var refresh
  
  var body: some View {
    Group {
      if let refresh = refresh {
        Button(
          action: {
            Task {
              await refresh()
            }
          },
          label: {
            Text("Refresh Button")
          }
        )
      }
    }
  }
}
