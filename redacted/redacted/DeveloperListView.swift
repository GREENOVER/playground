//
//  DeveloperListView.swift
//  redacted
//
//  Created by GREEN on 2022/09/08.
//

import SwiftUI

struct Developer: Hashable, Decodable {
  let name: String
  let description: String
  let followers: Int
}

extension Developer {
  static let mock = Developer(
    name: "GREEN",
    description: "The World's Most Famous iOS Developer",
    followers: 1229
  )
}

extension RedactionReasons {
  static let text = RedactionReasons(rawValue: 1 << 2)
  static let images = RedactionReasons(rawValue: 1 << 4)
}

extension View {
  @ViewBuilder func unredacted(when condition: Bool) -> some View {
    if condition {
      unredacted()
    } else {
      redacted(reason: .placeholder)
    }
  }
}

private struct DeveloperView: View {
  let developer: Developer
  
  var body: some View {
    HStack {
      VStack {
        Image(systemName: "person.fill")
          .resizable()
          .frame(width: 50, height: 50)
        Text(String(developer.followers))
          .font(.title)
      }
      .foregroundColor(.green)
      
      VStack {
        Text(developer.name)
          .font(.headline)
//          .unredacted()
        Text(developer.description)
          .foregroundColor(.secondary)
      }
    }
  }
}

private struct DeveloperReasonAdaptView: View {
  @Environment(\.redactionReasons) var reasons
  let developer: Developer
  
  var body: some View {
    HStack {
      VStack {
        Image(systemName: "person.fill")
          .resizable()
          .frame(width: 50, height: 50)
          .unredacted(when: !reasons.contains(.images))
        Text(String(developer.followers))
          .font(.title)
      }
      .foregroundColor(.green)
      
      VStack {
        Text(developer.name)
          .font(.headline)
        Text(developer.description)
          .foregroundColor(.secondary)
      }
    }
  }
}

struct DeveloperListView: View {
  @State var isLoading: Bool = false
  
  var body: some View {
    VStack(spacing: 10) {
      DeveloperReasonAdaptView(developer: .mock)
        .redacted(reason: .placeholder)
      Divider()
      DeveloperView(developer: .mock)
        .redacted(reason: .placeholder)
//        .redacted(reason: isLoading ? [] : .placeholder)
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
        isLoading = true
      })
    }
  }
}
