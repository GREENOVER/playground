//
//  TodoDetailView.swift
//  TodoList
//
//  Created by GREEN on 2023/08/07.
//

import SwiftUI

struct TodoDetailView: View {
  let todo: Todo
  
  var body: some View {
    VStack {
      Text(todo.title)
        .font(.largeTitle)
        .padding()
      
      Spacer()
    }
    .navigationBarTitleDisplayMode(.inline)
  }
}
