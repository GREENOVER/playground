//
//  CustomTab.swift
//  ScrollTab
//
//  Created by GREEN on 2023/07/10.
//

enum Tab: Int, Identifiable, Hashable, Comparable, TabTitleConvertible {
  case one
  case two
  case three
  case four
  case five
  case six
  case seven
  case eight
  
  var title: String {
    switch self {
    case .one: return "탭 1"
    case .two: return "탭 2"
    case .three: return "탭 3"
    case .four: return "탭 4"
    case .five: return "탭 5"
    case .six: return "탭 6"
    case .seven: return "탭 7"
    case .eight: return "탭 8"
    }
  }
  var id: Int {
    rawValue
  }
  
  static func < (lhs: Self, rhs: Self) -> Bool {
    return lhs.rawValue < rhs.rawValue
  }
}
