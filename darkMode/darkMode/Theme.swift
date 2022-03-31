//
//  Theme.swift
//  darkMode
//
//  Created by Chanwoo Cho on 2022/03/31.
//

import SwiftUI

struct Theme {
  static func backgroundColor(scheme: ColorScheme) -> Color {
    let lightColor = Color.white
    let darkColor = Color.gray
    
    switch scheme {
    case .light:
      return lightColor
    case .dark:
      return darkColor
    @unknown default:
      return lightColor
    }
  }
}
