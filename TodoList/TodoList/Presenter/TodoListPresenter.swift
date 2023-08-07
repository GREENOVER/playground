//
//  TodoListPresenter.swift
//  TodoList
//
//  Created by GREEN on 2023/08/07.
//

import SwiftUI

class TodoListPresenter: ObservableObject {
  @Published var todos: [Todo] = []
  @ObservedObject var router: TodoListRouter
  private let interactor: TodoListInteractorInput
  
  init(
    interactor: TodoListInteractorInput,
    router: TodoListRouter
  ) {
    self.interactor = interactor
    self.router = router
    fetchTodos()
  }
  
  private func fetchTodos() {
    todos = interactor.fetchTodos()
  }
  
  func didSelectedTodo(_ todo: Todo) {
    router.moveToSelectedTodoDetail(todo: todo)
  }
  
  func didFinishDisplayTodoDetail() {
    router.closeSelectedTodoDetail()
  }
}
