//
//  ContentView.swift
//  Sticky
//
//  Created by GREEN on 2023/07/06.
//

import SwiftUI

struct ContentView: View {
  @State var selectedTab: String = "First"
  
  var body: some View {
    VStack(spacing: 0) {
      Text("Sticky View")
        .font(.title)
        .bold()
        .frame(height: 50)
      
      ScrollViewReader { proxy in
        ScrollView {
          TopView()
          
          LazyVStack(
            spacing: 10,
            pinnedViews: .sectionHeaders
          ) {
            Section(header: HeaderView(selectedTab: $selectedTab, action: { proxy.scrollTo("Header", anchor: .top)})) {
              switch selectedTab {
              case "First":
                ItemsView(color: .blue)
                
              case "Second":
                ItemsView(color: .yellow)
                
              default:
                ItemsView(color: .green, count: 2)
              }
              Spacer()
            }
          }
        }
      }
    }
  }
}

// MARK: - 탑 타이틀 뷰
struct TopView: View {
  var body: some View {
    HStack {
      Spacer()
      
      Text("Here is Top")
        .font(.title)
        .bold()
      
      Spacer()
    }
    .background(Color.green.opacity(0.5))
    .frame(height: 50)
  }
}

// MARK: - 고정될 헤더 뷰
struct HeaderView: View {
  @Binding var selectedTab: String
  var action: () -> Void
  
  var body: some View {
    HStack {
      Spacer()
      
      Button(
        action: {
          selectedTab = "First"
          action()
        },
        label: {
          Text("First")
            .font(.title)
            .bold()
            .foregroundColor(selectedTab == "First" ? .black : .gray)
        }
      )
      
      Button(
        action: {
          selectedTab = "Second"
          action()
        },
        label: {
          Text("Second")
            .font(.title)
            .bold()
            .foregroundColor(selectedTab == "Second" ? .black : .gray)
        }
      )
      
      Button(
        action: {
          selectedTab = "Third"
          action()
        },
        label: {
          Text("Third")
            .font(.title)
            .bold()
            .foregroundColor(selectedTab == "Third" ? .black : .gray)
        }
      )
      
      Spacer()
    }
    .frame(height: 50)
    .background(.white)
    .id("Header")
  }
}

// MARK: - 컨텐츠로 담길 아이템 뷰
struct ItemsView: View {
  let color: Color
  let count: Int
  
  init(color: Color, count: Int = 20) {
    self.color = color
    self.count = count
  }
  
  var body: some View {
    VStack {
      ForEach(0...count, id: \.self) { _ in
        Rectangle()
          .fill(color)
          .cornerRadius(10)
          .frame(height:100)
      }
      
      Spacer()
    }
    .padding(.horizontal, 20)
    .frame(minHeight: UIScreen.main.bounds.height - 150)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
