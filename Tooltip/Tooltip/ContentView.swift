//
//  ContentView.swift
//  Tooltip
//
//  Created by GREEN on 2023/06/22.
//

import SwiftUI

struct ContentView: View {
  @State var isDisplayTooltip: Bool = true
  @State private var tooltipOpacity: Double = 1
  @State private var tooltipScale: CGFloat = 1
  
  var body: some View {
    VStack(spacing: 4) {
      HStack {
        Spacer()
        
        Text("Tooltip 안내")
          .padding(.trailing, 16)
      }
      
      if isDisplayTooltip {
        TooltipView(isDisplayTooltip: $isDisplayTooltip)
          .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
              isDisplayTooltip = false
            }
          }
      }
      
      Spacer()
    }
    .padding()
  }
}

// MARK: - Tooltip View
private struct TooltipView: View {
  @Binding var isDisplayTooltip: Bool
  
  fileprivate var body: some View {
    HStack {
      Spacer()
      
      TooltipShape()
        .onTapGesture {
          isDisplayTooltip = false
        }
    }
  }
}

// MARK: - Tooltip Shape
private struct TooltipShape: View {
  fileprivate var body: some View {
    ZStack {
      CustomTriangleShape()
        .fill(.green)
        .padding(.leading, 178)
      
      CustomRectangleShape(text: "Tooltip 입니다!")
    }
    .frame(width: 216, height: 45)
  }
}

// MARK: - Custom Rectangle Shape
private struct CustomRectangleShape: View {
  private var text: String
  
  fileprivate init(text: String) {
    self.text = text
  }
  
  fileprivate var body: some View {
    VStack {
      Spacer()
      
      Text(text)
        .font(.title)
        .foregroundColor(.white)
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(
          RoundedRectangle(cornerRadius:20)
            .fill(.green)
        )
    }
  }
}

// MARK: - Custom Triangle Shape
private struct CustomTriangleShape: Shape {
  private var width: CGFloat
  private var height: CGFloat
  private var radius: CGFloat
  
  fileprivate init(
    width: CGFloat = 24,
    height: CGFloat = 24,
    radius: CGFloat = 1
  ) {
    self.width = width
    self.height = height
    self.radius = radius
  }
  
  fileprivate func path(in rect: CGRect) -> Path {
    var path = Path()
    
    path.move(to: CGPoint(x: rect.minX + width / 2 - radius, y: rect.minY))
    path.addQuadCurve(
      to: CGPoint(x: rect.minX + width / 2 + radius, y: rect.minY),
      control: CGPoint(x: rect.minX + width / 2, y: rect.minY + radius)
    )
    path.addLine(to: CGPoint(x: rect.minX + width, y: rect.minY + height))
    path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + height))
    
    path.closeSubpath()
    
    return path
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
