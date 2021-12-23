//
//  ContentView.swift
//  swipeActions
//
//  Created by Chanwoo Cho on 2021/12/23.
//

import SwiftUI

struct SwipeActionView: View {
  @State private var actionTitle = ""
  
  var body: some View {
    NavigationView {
      List {
        ForEach(1..<10) { num in
          Text("Number is \(num)")
            .swipeActions(edge: .leading, allowsFullSwipe: false) {
              Button {
                actionTitle = "Counting Star"
              } label: {
                Label("Star", systemImage: "star.circle")
              }
              .tint(.green)
            }
            .swipeActions(edge: .trailing) {
              Button(role: .destructive){
                actionTitle = "Move the trash"
              } label: {
                Label("Trash", systemImage: "trash.circle")
              }
              .tint(.red)
              Button{
                actionTitle = "Pick the flag"
              } label: {
                Label("Flag", systemImage: "flag.circle")
              }
              .tint(.blue)
            }
        }
      }
      .navigationTitle("\(actionTitle)")
    }
  }
}


struct SwipeActionView_Previews: PreviewProvider {
  static var previews: some View {
    SwipeActionView()
  }
}
