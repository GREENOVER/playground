//
//  Tab.swift
//  CustomTabView
//
//  Created by GREEN on 2023/07/03.
//

enum Tab: Int, Identifiable, Hashable, Comparable, TabTitleConvertible {
  case one
  case two
  case three
  
  var title: String {
    switch self {
    case .one: return "탭 1"
    case .two: return "탭 2"
    case .three: return "탭 3"
    }
  }
  var id: Int {
    rawValue
  }
  
  static func < (lhs: Self, rhs: Self) -> Bool {
    return lhs.rawValue < rhs.rawValue
  }
}
