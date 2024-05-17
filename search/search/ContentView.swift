//
//  ContentView.swift
//  search
//
//  Created by GREEN on 5/17/24.
//

import SwiftUI

// Model
struct Animal: Identifiable {
  var id = UUID()
  var name: String
}

// View
struct ContentView: View {
  let animals: [Animal] = [
    .init(name: "dog"),
    .init(name: "cat"),
    .init(name: "cow"),
    .init(name: "bird"),
    .init(name: "pig"),
    .init(name: "monkey"),
    .init(name: "snake")
  ]
  
  @State private var searchText: String = ""
  @State private var selectedScope: String = "All"
  var scopes = ["All", "Mammals", "Birds", "Reptiles"]
  var filteredAnimals: [Animal] {
    let filteredByScope = animalsFilteredByScope
    if searchText.isEmpty {
      return filteredByScope
    } else {
      return filteredByScope.filter { $0.name.contains(searchText.lowercased()) }
    }
  }
  
  var animalsFilteredByScope: [Animal] {
    switch selectedScope {
    case "Mammals":
      return animals.filter { ["dog", "cat", "cow", "pig", "monkey"].contains($0.name) }
    case "Birds":
      return animals.filter { ["bird"].contains($0.name) }
    case "Reptiles":
      return animals.filter { ["snake"].contains($0.name) }
    default:
      return animals
    }
  }
  
  var body: some View {
    NavigationStack {
      List(filteredAnimals) { animal in
        Text(animal.name)
      }
      .searchable(text: $searchText, prompt: "Search animals")
      .searchScopes($selectedScope) {
        ForEach(scopes, id: \.self) { scope in
          Text(scope)
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
