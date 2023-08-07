//
//  TodoListInteractor.swift
//  TodoList
//
//  Created by GREEN on 2023/08/07.
//

import Foundation

protocol TodoListInteractorInput: AnyObject {
  func fetchTodos() -> [Todo]
}

class TodoListInteractor: TodoListInteractorInput {
  func fetchTodos() -> [Todo] {
    let todos = (1...10).map {
      Todo(title: "할 일 \($0)")
    }
    return todos
  }
}
