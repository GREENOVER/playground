//
//  ContentView.swift
//  multiLine
//
//  Created by Chanwoo Cho on 2022/01/19.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    MultiLineView()
    Spacer().frame(height: 30)
    LineLimitView()
    Spacer().frame(height: 30)
    LineSpacingView()
  }
}

struct MultiLineView: View {
  var body: some View {
    Text("multiLine Text Alignment Test")
      .font(.largeTitle)
      .bold()
    VStack(spacing: 10) {
      Text("Have a nice trip\nGood Day\nLet's go")
        .frame(alignment: .leading)
        .multilineTextAlignment(.leading)
        .background(Color.green)
      
      Text("Have a nice trip\nGood Day\nLet's go")
        .frame(alignment: .leading)
        .multilineTextAlignment(.trailing)
        .background(Color.blue)
      
      Text("Have a nice trip\nGood Day\nLet's go")
        .frame(alignment: .leading)
        .multilineTextAlignment(.center)
        .background(Color.orange)
    }
  }
}

struct LineLimitView: View {
  var body: some View {
    Text("line Limit Test")
      .font(.largeTitle)
      .bold()
    VStack(spacing: 10) {
      Text("Have a nice trip\nGood Day\nLet's go")
        .frame(alignment: .leading)
        .multilineTextAlignment(.leading)
        .lineLimit(2)
        .background(Color.green)
      Text("Have a nice trip\nGood Day\nLet's go")
        .frame(alignment: .leading)
        .multilineTextAlignment(.leading)
        .lineLimit(nil)
        .background(Color.blue)
    }
  }
}

struct LineSpacingView: View {
  var body: some View {
    Text("line Spacing Test")
      .font(.largeTitle)
      .bold()
    VStack(spacing: 10) {
      Text("Have a nice trip\nGood Day\nLet's go")
        .frame(alignment: .leading)
        .multilineTextAlignment(.leading)
        .lineSpacing(10)
        .background(Color.green)
      Text("Have a nice trip\nGood Day\nLet's go")
        .frame(alignment: .leading)
        .multilineTextAlignment(.leading)
        .lineSpacing(50)
        .background(Color.blue)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
