//
//  ContentViewModel.swift
//  CustomTabView
//
//  Created by GREEN on 2023/07/03.
//

import SwiftUI

class ContentViewModel: ObservableObject {
  @Published var selectedTab: Tab = .one
}
