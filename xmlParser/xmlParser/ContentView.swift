//
//  ContentView.swift
//  xmlParser
//
//  Created by GREEN on 5/20/24.
//

import SwiftUI

struct ContentView: View {
  @State private var animals: [Animal] = []
  
  var body: some View {
    NavigationView {
      List(animals) { animal in
        VStack(alignment: .leading) {
          Text(animal.name)
          
          Text(animal.owner)
          
          Text(animal.age)
        }
      }
      .navigationTitle("Animals")
      .task {
        loadXMLData()
      }
    }
  }
  
  private func loadXMLData() {
    if let url = Bundle.main.url(forResource: "animals", withExtension: "xml") {
      if let data = try? Data(contentsOf: url) {
        let parser = AnimalXMLParser()
        animals = parser.parse(data: data)
      }
    }
  }
}
