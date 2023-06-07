//
//  ContentView.swift
//  SwiftUI5
//
//  Created by GREEN on 2023/06/07.
//

import SwiftData
import SwiftUI

struct ContentView: View {
  @Environment(\.modelContext) private var context
  @Query(sort: \.age) var people: [Person]
  var colors: [Color] = [.accentColor, .green, .red, .blue, .purple, .pink]
  @State private var scrollPosition: Color?
  @State private var transitionBtnClicked: Bool = false
  
  var body: some View {
    // 트랜지션
//    VStack {
//      if transitionBtnClicked {
//        Rectangle()
//          .fill(.green)
//          .frame(width: 100, height: 100)
//          .transition(GreenTransition())
//      }
//      
//      Button("Let's Transition") {
//        withAnimation(.bouncy) {
//          transitionBtnClicked.toggle()
//        }
//      }
//    }
    
    // UnevenRoundedRectangle
//    UnevenRoundedRectangle(topLeadingRadius: 10)
//      .fill(.green.gradient)
//      .frame(width: 200, height: 200) 
//    
//    Rectangle()
//      .fill(.green.gradient)
//      .frame(width: 200, height: 200)
//      .clipShape(.rect(topLeadingRadius: 10))
    
    VStack {
      ScrollView {
        VStack(spacing: 30) {
          ForEach(people, id: \.id) { person in
            PersonCardView(person: person)
              .scrollTransition { content, phase in
                content
                  .scaleEffect(phase.isIdentity ? 1 : 0.6)
                  .opacity(phase.isIdentity ? 1 : 0)
              }
          }
        }
      }
      .overlay(alignment: .bottom) {
        if let scrollPosition {
          Text(scrollPosition == .red ? "Red": "Other")
        }
      }
      .safeAreaInset(edge: .top) {
        ScrollView(.horizontal) {
          HStack {
            ForEach(colors, id: \.self) { color in
              TopCardView(color: color)
                .containerRelativeFrame(
                  .horizontal,
                  count: 5,
                  span: 2,
                  spacing: 10
                )
            }
          }
          .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollPosition(id: $scrollPosition)
      }
      
      Button(
        action: {
          context.insert(
            Person(
              name: "Green",
              age: Int.random(in: 0...100)
            )
          )
          do {
            try context.save()
          } catch {
            print(error.localizedDescription)
          }
        },
        label: {
          Text("Add Person")
        }
      )
      .buttonStyle(.bordered)
      .buttonBorderShape(.roundedRectangle)
      .springLoadingBehavior(.enabled)
    }
  }
}

// MARK: - 상단 카드 뷰
struct TopCardView: View {
  var color: Color
  
  var body: some View {
    Rectangle()
      .frame(width: 100, height: 100)
      .foregroundStyle(color)
  }
}

// MARK: - 사람 카드 뷰
struct PersonCardView: View {
  @State var person: Person
  var zoomLevel: CGSize = .zero
  
  var body: some View {
    HStack(alignment: .center, spacing: 10) {
      Text(person.name)
        .typesettingLanguage(.init(languageCode: .thai))
        .foregroundStyle(.customGreen)
      
      AsyncImage(url: URL(string: "https://i.pravatar.cc/150?u=fake@pravatar.com"))
      
      Text("\(person.age)")
    }
  }
}

// MARK: - 사람 모델
@Model
class Person: Identifiable {
  var id = UUID()
  var name: String
  var age: Int
  
  init(id: UUID = UUID(), name: String, age: Int) {
    self.id = id
    self.name = name
    self.age = age
  }
}

// MARK: - Custom Transition
struct GreenTransition: Transition {
  func body(content: Content, phase: TransitionPhase) -> some View {
    content
      .rotation3DEffect(
        .init(degrees: phase.value * (phase == .willAppear ? 90 : -90)),
        axis: (x: 1.0, y: 0.0, z: 0.0)
      )
  }
}

// MARK: - Custom Animation
struct GreenAnimation: CustomAnimation {
  var duration: CGFloat
  
  func animate<V>(value: V, time: TimeInterval, context: inout AnimationContext<V>) -> V? where V : VectorArithmetic {
    if time > duration { return nil }
    
    return value.scaled(by: time / duration)
  }
}
