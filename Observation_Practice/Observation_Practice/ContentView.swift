//
//  ContentView.swift
//  Observation_Practice
//
//  Created by GREEN on 2023/06/08.
//

import SwiftUI
import Observation

struct ContentView: View {
  var dogList: DogList
  @State private var dogToAdd: Dog?
  @Bindable private var dog2: Dog = .init(name: "green", age: 3)
  
  var body: some View {
    TextField("name", text: $dog2.name)
    
    Button(action: { dogList.dogs.append(dog2) }, label: {
      Text("saveee")
    })
    
    List(dogList.dogs) { DogView(dog: $0) }
    
    Button("Add Dog") { dogToAdd = Dog(name: "Dog\(Int.random(in: 1...100))", age: Int.random(in: 1...100)) }
      .sheet(item: $dogToAdd) { dog in
        Button("Save") {
          dogList.dogs.append(dogToAdd ?? .init(name: "Puppy", age: 3))
          dogToAdd = nil
        }
        
        Button("Cancel") { dogToAdd = nil }
      }
  }
}

// MARK: - 강아지 셀 뷰
private struct DogView: View {
  let dog: Dog
  
  init(dog: Dog) {
    self.dog = dog
  }
  
  var body: some View {
    HStack(spacing: 10) {
      Spacer()
      
      Text(dog.name)
        .font(.title)
      
      Text("\(dog.age)")
        .font(.caption)
      
      Spacer()
    }
  }
}

#Preview {
  ContentView(dogList: .init(dogs: []))
}

// MARK: - 강아지 모델
@Observable
class Dog: Identifiable {
  var name: String = ""
  var age: Int = 0
  
  init(name: String, age: Int) {
    self.name = name
    self.age = age
  }
}

@Observable
class DogList {
  var dogs: [Dog] = []
  
  init(dogs: [Dog]) {
    self.dogs = dogs
  }
}
