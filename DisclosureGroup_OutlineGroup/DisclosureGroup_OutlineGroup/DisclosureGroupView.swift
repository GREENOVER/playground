//
//  ContentView.swift
//  DisclosureGroup_OutlineGroup
//
//  Created by GREEN on 2022/09/29.
//

import SwiftUI

struct DisclosureGroupView: View {
  @State private var firstExpanded: Bool = false
  @State private var secondExpanded: Bool = true
  
  var body: some View {
    DisclosureGroup("1번 그룹", isExpanded: $firstExpanded) {
      Text("1번 그룹에 속한 텍스트")
      DisclosureGroup("2번 그룹", isExpanded: $secondExpanded) {
        Text("2번 그룹에 속한 텍스트")
      }
    }
  }
}
