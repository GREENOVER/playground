//
//  ContentView.swift
//  isDetailLink
//
//  Created by GREEN on 2022/08/22.
//

import SwiftUI

struct ParentView: View {
  @State var isActive : Bool = false
  
  var body: some View {
    NavigationView {
      NavigationLink(
        destination: ChildView(parentViewIsActive: self.$isActive),
        isActive: self.$isActive
      ) {
        Text("I'm Parent View")
      }
//      .isDetailLink(true)
      .isDetailLink(false)
      .navigationBarTitle("Parent")
    }
  }
}

struct ChildView: View {
  @Binding var parentViewIsActive : Bool
  
  var body: some View {
    NavigationLink(
      destination: GrandsonView(shouldPopToParentView: self.$parentViewIsActive)
    ) {
      Text("I'm Child View")
    }
//    .isDetailLink(true)
    .isDetailLink(false)
    .navigationBarTitle("Child")
  }
}

struct GrandsonView: View {
  @Binding var shouldPopToParentView : Bool
  
  var body: some View {
    VStack {
      Text("I'm Grandson View")
      Button (
        action: { self.shouldPopToParentView = false }
      ) {
        Text("Pop to Parent View")
      }
    }
    .navigationBarTitle("Grandson")
  }
}
