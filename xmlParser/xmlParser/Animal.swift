//
//  Animal.swift
//  xmlParser
//
//  Created by GREEN on 5/20/24.
//

import Foundation

struct Animal: Identifiable {
  let id = UUID()
  let name: String
  let owner: String
  let age: String
}
