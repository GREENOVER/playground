//
//  ContentView.swift
//  popupView
//
//  Created by GREEN on 2023/02/06.
//

import SwiftUI
import PopupView

struct ContentView: View {
  var body: some View {
    // 플로팅 예제 뷰
//    FloatingTotalView()
    
    // 바텀 시트 예제 뷰
    BottomSheetView()
  }
}

private struct FloatingTotalView: View {
  @State var isPresentedFloating: Bool = false
  
  var body: some View {
    VStack {
      Text("Hello PopupView !")
      Spacer()
      Button(
        action: { isPresentedFloating.toggle() },
        label: {
          Text("Show Floating")
//            .popup(isPresented: $isPresentedFloating) {
//              FloatingView()
//            } customize: {
//              $0
//                .type(.floater())
//                .animation(.spring())
//                .isOpaque(true)
//                .backgroundColor(.black.opacity(0.5))
//            }
        }
      )
    }
    .padding()
    .popup(isPresented: $isPresentedFloating) {
      FloatingView()
    } customize: {
      $0
        .type(.floater())
        .position(.top)
        .animation(.spring())
        .closeOnTapOutside(true)
        .backgroundColor(.black.opacity(0.5))
    }
  }
}

private struct BottomSheetView: View {
  @State var isPresentedBottomSheet: Bool = false
  
  var body: some View {
    VStack {
      Button(
        action: { isPresentedBottomSheet.toggle() },
        label: {
          Text("Show Bottom Sheet")
        }
      )
    }
    .padding()
    .popup(isPresented: $isPresentedBottomSheet) {
      VStack {
        HStack {
          Spacer()
          Text("This is Bottom Sheet")
            .padding(.top, 10)
          Spacer()
        }
        Spacer()
      }
      .background(Color.white)
      .frame(height: 150)
      .cornerRadius(20)
    } customize: {
      $0
        .type(.toast)
        .position(.bottom)
        .dragToDismiss(true)
        .closeOnTapOutside(true)
        .backgroundColor(.black.opacity(0.5))
    }
  }
}

private struct FloatingView: View {
  var body: some View {
    HStack {
      Spacer()
      Text("This is Floating")
        .font(.headline)
        .padding(.vertical, 10)
      Spacer()
    }
    .background(Color.white)
    .cornerRadius(20)
    .padding(.horizontal, 20)
  }
}
