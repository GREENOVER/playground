//
//  ContentView.swift
//  custom-stepper
//
//  Created by Chanwoo Cho on 2022/01/28.
//

import SwiftUI

struct ContentView: View {
  @State var count: Int = 1
  
  var body: some View {
    HStack(spacing: 0) {
      StepperView(
        title: "-",
        color: count == 1 ? .red : .gray
      ) {
        if count > 1 {
          count -= 1
        }
      }
      Rectangle().foregroundColor(.black)
        .frame(width: 1, height: 15)
      StepperView(title: "+") {
        count += 1
      }
    }
    .background(.yellow)
    .cornerRadius(10)
    
    Text("count is \(count)")
      .font(.largeTitle)
      .padding()
  }
}

private struct StepperView: View {
  @State private var timer: Timer?
  @State private var isLongPressing = false
  
  public var title: String
  public var color: Color = .gray
  public var action: () -> Void = {}
  
  public init(
    title: String,
    color: Color = .gray,
    action: @escaping () -> Void = {}
  ) {
    self.title = title
    self.color = color
    self.action = action
  }
  
  var body: some View {
    Button(
      action: {
        if self.isLongPressing {
          self.isLongPressing.toggle()
          self.timer?.invalidate()
        } else {
          self.action()
        }
      },
      label: {
        HStack(spacing: 0) {
          Text(title)
            .font(.largeTitle)
            .padding(.horizontal, 16)
            .padding(.vertical, 9)
        }
        .foregroundColor(color)
        .frame(height: 30)
      }
    )
      .padding(.horizontal, 30)
      .simultaneousGesture(
        LongPressGesture(minimumDuration: 0.5)
          .onEnded { _ in
            self.isLongPressing = true
            self.timer = Timer.scheduledTimer(
              withTimeInterval: 0.1,
              repeats: true,
              block: { _ in
                self.action()
              }
            )
          }
      )
      .simultaneousGesture(
        DragGesture()
          .onEnded { _ in
            self.isLongPressing.toggle()
            self.timer?.invalidate()
          }
      )
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
