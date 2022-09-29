//
//  OutlineGroupView.swift
//  DisclosureGroup_OutlineGroup
//
//  Created by GREEN on 2022/09/29.
//

import SwiftUI

struct FileItem: Hashable, Identifiable, CustomStringConvertible {
  var id: Self { self }
  var name: String
  var children: [FileItem]? = nil
  var description: String {
    switch children {
    case nil:
      return "📄 \(name)"
    case .some(let children):
      return children.isEmpty ? "📂 \(name)" : "📁 \(name)"
    }
  }
}

struct OutlineGroupView: View {
  let data =
  FileItem(
    name: "GREEN",
    children: [
      FileItem(
        name: "GREEN1229",
        children: [
          FileItem(
            name: "Posting",
            children:  [
              FileItem(
                name: "SwiftUI.jpg"),
              FileItem(name: "UIKit.jpg")]),
          FileItem(
            name: "Simulator",
            children: [
              FileItem(name: "Run.mp4")]),
          FileItem(name: "Etc", children: [])
        ]),
      FileItem(
        name: "Hobby",
        children: [
          FileItem(name: "Travel", children: [])
        ])
    ])
  
  var body: some View {
    OutlineGroup(data, children: \.children) { item in
      Text("\(item.description)")
    }
  }
}
