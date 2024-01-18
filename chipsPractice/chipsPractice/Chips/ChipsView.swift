//
//  ChipsView.swift
//  chipsPractice
//
//  Created by GREEN on 2024/01/18.
//

import SwiftUI

public struct ChipsView: View {
  private var title: String
  
  public init(title: String) {
    self.title = title
  }
  
  public var body: some View {
    Text(title)
      .font(.caption)
      .foregroundColor(.black)
      .padding(.horizontal, 10)
      .padding(.vertical, 3)
      .background(.white)
      .cornerRadius(16)
      .overlay(
        RoundedRectangle(cornerRadius: 16)
          .stroke(.green, lineWidth: 1)
      )
      .frame(height: 24)
  }
}
