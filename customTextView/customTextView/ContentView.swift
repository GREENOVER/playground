//
//  ContentView.swift
//  customTextView
//
//  Created by GREEN on 2023/02/17.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Spacer()
        .frame(height: 100)
      
      Button(
        action: {
          UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        },
        label: {
          Text("Hide Keyboard")
        }
      )
      
      Spacer()
      
      TextWritingView()
        .background(.gray)
    }
  }
}

private struct TextWritingView: View {
  @State private var height: CGFloat = 30
  @State var text: String = ""
  private var registerButtonDisabled: Bool {
    text.isEmpty
  }
  private var registerButtonTextColor: Color {
    text.isEmpty ? .red : .green
  }
  
  var body: some View {
    HStack(alignment: .bottom, spacing: 10) {
      // 댓글 입력창
      CustomTextView(
        text: $text,
        height: $height,
        maxHeight: 200,
        textFont: .boldSystemFont(ofSize: 14),
        cornerRadius: 5,
        borderWidth: 1,
        borderColor: CGColor.init(red: 255, green: 255, blue: 255, alpha: 1),
        placeholder: "댓글을 입력해 주세요"
      )
      .frame(minHeight: height, maxHeight: .infinity)
      
      // 등록 버튼
      Button(
        action: {
          UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        },
        label: {
          Text("등록")
            .foregroundColor(registerButtonTextColor)
        }
      )
      .disabled(registerButtonDisabled)
      .padding(.bottom, 5)
    }
    .padding(.all, 10)
    .frame(height: 50)
    .frame(minHeight: height + 20)
  }
}
