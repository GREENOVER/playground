//
//  TodoListInteractor.swift
//  TodoList
//
//  Created by GREEN on 2023/08/07.
//

import Foundation

protocol TodoListInteractorInput: AnyObject {
  func fetchTodos(completion: @escaping (Result<[Todo], Error>) -> Void)
}

class TodoListInteractor: TodoListInteractorInput {
  private let todoNetworkService: TodoNetworkServiceProtocol
  
  init(todoNetworkService: TodoNetworkServiceProtocol) {
    self.todoNetworkService = todoNetworkService
  }

  func fetchTodos(completion: @escaping (Result<[Todo], Error>) -> Void) {
    todoNetworkService.getTodos(completion: completion)
  }
}
