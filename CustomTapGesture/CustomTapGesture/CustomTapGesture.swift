//
//  CustomTapGesture.swift
//  CustomTapGesture
//
//  Created by GREEN on 2022/11/07.
//

import SwiftUI

public struct CustomTapGesture: Gesture {
  public typealias Value = SimultaneousGesture<TapGesture, DragGesture>.Value
  
  let count: Int
  let coordinateSpace: CoordinateSpace
  
  init(
    count: Int = 1,
    coordinateSpace: CoordinateSpace = .global
  ) {
    self.count = count
    self.coordinateSpace = coordinateSpace
  }
  
  public var body: SimultaneousGesture<TapGesture, DragGesture> {
    SimultaneousGesture(
      TapGesture(count: count),
      DragGesture(minimumDistance: 0, coordinateSpace: coordinateSpace)
    )
  }
  
  public func onEnded(perform action: @escaping (CGPoint) -> Void) -> _EndedGesture<CustomTapGesture> {
    self.onEnded { (value: Value) -> Void in
      guard value.first != nil else { return }
      guard let location = value.second?.startLocation else { return }
      guard let endLocation = value.second?.location else { return }
      guard ((location.x-1)...(location.x+1))
        .contains(endLocation.x), ((location.y-1)...(location.y+1))
        .contains(endLocation.y) else {
        return
      }
      action(location)
    }
  }
}
