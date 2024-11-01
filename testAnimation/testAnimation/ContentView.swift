//
//  ContentView.swift
//  testAnimation
//
//  Created by GREEN on 11/1/24.
//

import SwiftUI

struct ContentView: View {
  @State private var isTopViewSelected = false
  @State private var isBottomViewSelected = false
  
  var body: some View {
    ZStack {
      // 배경
      if isTopViewSelected {
        Color.blue
          .ignoresSafeArea()
      } else if isBottomViewSelected {
        Color.orange
          .ignoresSafeArea()
      }
      
      
      VStack(spacing: 0) {
        // 상단 뷰
        HStack {
          Spacer()
          
          Button(
            action: {
              withAnimation(.spring(response: 1.0, dampingFraction: 0.7)) {
                isTopViewSelected.toggle()
                isBottomViewSelected = false
              }
            }
          ) {
            Image("apple")
              .resizable()
              .frame(
                width: 100,
                height: 100
              )
              .scaleEffect(isTopViewSelected ? 3 : 1)
          }
          .offset(
            x: isBottomViewSelected ? UIScreen.main.bounds.width + 100 : 0,
            y: isTopViewSelected ?
            UIScreen.main.bounds.height/4 :
              (isBottomViewSelected ? UIScreen.main.bounds.height + 100 : 0)
          )
          
          Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(isTopViewSelected || isBottomViewSelected ? Color.clear : Color.blue)
        
        // 하단 뷰
        HStack {
          Spacer()
          
          Button(
            action: {
              withAnimation(.spring(response: 1.0, dampingFraction: 0.7)) {
                isBottomViewSelected.toggle()
                isTopViewSelected = false
              }
            }
          ) {
            Image("nvidia")
              .resizable()
              .frame(
                width: isBottomViewSelected ? 300 : 100,
                height: isBottomViewSelected ? 300 : 100
              )
          }
          .offset(
            x: isTopViewSelected ? UIScreen.main.bounds.width + 100 : 0,
            y: isBottomViewSelected ?
            -UIScreen.main.bounds.height/4 :
            (isTopViewSelected ? UIScreen.main.bounds.height + 100 : 0)
          )
          
          Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(isTopViewSelected || isBottomViewSelected ? Color.clear : Color.orange)
      }
    }
    .ignoresSafeArea()
  }
}

#Preview {
  ContentView()
}
