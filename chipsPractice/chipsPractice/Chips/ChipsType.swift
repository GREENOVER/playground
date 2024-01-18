//
//  ChipsType.swift
//  chipsPractice
//
//  Created by GREEN on 2024/01/18.
//

public struct ChipsType: Equatable {
  let title: String
  let priority: Int
  
  public init(
    title: String,
    priority: Int = 0
  ) {
    self.title = title
    self.priority = priority
  }
  
  public static func == (lhs: ChipsType, rhs: ChipsType) -> Bool {
    lhs.title == rhs.title
  }
}
