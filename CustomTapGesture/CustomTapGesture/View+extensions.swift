//
//  View+extensions.swift
//  CustomTapGesture
//
//  Created by GREEN on 2022/11/07.
//

import SwiftUI

extension View {
  public func onCustomTapGesture(
    count: Int,
    coordinateSpace: CoordinateSpace = .global,
    perform action: @escaping (CGPoint) -> Void
  ) -> some View {
    simultaneousGesture(CustomTapGesture(count: count, coordinateSpace: coordinateSpace)
      .onEnded(perform: action)
    )
  }
  
  public func onCustomTapGesture(
    count: Int,
    perform action: @escaping (CGPoint) -> Void
  ) -> some View {
    onCustomTapGesture(count: count, coordinateSpace: .global, perform: action)
  }
  
  public func onCustomTapGesture(
    perform action: @escaping (CGPoint) -> Void
  ) -> some View {
    onCustomTapGesture(count: 1, coordinateSpace: .global, perform: action)
  }
}
