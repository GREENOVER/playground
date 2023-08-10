//
//  TodoNetworkService.swift
//  TodoList
//
//  Created by GREEN on 2023/08/10.
//

import Foundation

protocol TodoNetworkServiceProtocol {
  func getTodos(completion: @escaping (Result<[Todo], Error>) -> Void)
}

struct TodoNetworkService: TodoNetworkServiceProtocol {
  private let baseURL = URL(string: "여기에 API URL을 넣어줍니다!")!
  
  func getTodos(completion: @escaping (Result<[Todo], Error>) -> Void) {
    URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
      if let error = error {
        completion(.failure(error))
        return
      }
      
      guard let data = data else {
        let error = NSError(
          domain: "",
          code: 0,
          userInfo: [NSLocalizedDescriptionKey: "서버에서 데이터를 받지 못했습니다."]
        )
        completion(.failure(error))
        return
      }
      
      do {
        let decoder = JSONDecoder()
        let todos = try decoder.decode([Todo].self, from: data)
        completion(.success(todos))
      } catch {
        completion(.failure(error))
      }
    }.resume()
  }
}
