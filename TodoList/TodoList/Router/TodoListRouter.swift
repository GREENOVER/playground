//
//  TodoListRouter.swift
//  TodoList
//
//  Created by GREEN on 2023/08/07.
//

import Combine

class TodoListRouter: ObservableObject {
  @Published var selectedTodo: Todo? = nil
  
  func moveToSelectedTodoDetail(todo: Todo) {
    self.selectedTodo = todo
  }
  
  func closeSelectedTodoDetail() {
    self.selectedTodo = nil
  }
}
