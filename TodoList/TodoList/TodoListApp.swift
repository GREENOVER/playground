//
//  TodoListApp.swift
//  TodoList
//
//  Created by GREEN on 2023/08/07.
//

import SwiftUI

@main
struct TodoListApp: App {
  var body: some Scene {
    WindowGroup {
      TodoListView(
        presenter: TodoListPresenter(
          interactor: TodoListInteractor(),
          router: TodoListRouter()
        )
      )
    }
  }
}
