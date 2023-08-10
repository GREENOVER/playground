//
//  TodoListView.swift
//  TodoList
//
//  Created by GREEN on 2023/08/07.
//

import SwiftUI

struct TodoListView: View {
  @ObservedObject var presenter: TodoListPresenter
  
  var body: some View {
    NavigationView {
      List(presenter.todos) { todo in
        NavigationLink(
          destination: TodoDetailView(todo: todo),
          isActive: Binding(
            get: {
              presenter.router.selectedTodo?.id == todo.id
            },
            set: { isActive in
              if isActive {
                presenter.didSelectedTodo(todo)
              } else {
                presenter.didFinishDisplayTodoDetail()
              }
            }
          ),
          label: {
            Text(todo.title)
          }
        )
      }
      .navigationTitle("Todo List")
    }
  }
}

struct TodoListView_Previews: PreviewProvider {
  static var previews: some View {
    let interactor = TodoListInteractor(todoNetworkService: TodoNetworkService())
    let router = TodoListRouter()
    let presenter = TodoListPresenter(interactor: interactor, router: router)
    
    return TodoListView(presenter: presenter)
  }
}
