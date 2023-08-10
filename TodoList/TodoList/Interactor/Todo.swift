//
//  Todo.swift
//  TodoList
//
//  Created by GREEN on 2023/08/07.
//

import Foundation

struct Todo: Identifiable, Decodable {
  var id = UUID()
  let title: String
}
