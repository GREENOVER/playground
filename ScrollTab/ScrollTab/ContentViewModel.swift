//
//  ContentViewModel.swift
//  ScrollTab
//
//  Created by GREEN on 2023/07/10.
//

import SwiftUI

class ContentViewModel: ObservableObject {
  @Published var selectedTab: Tab = .one
}

