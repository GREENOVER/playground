//
//  ContentView.swift
//  animation_practice
//
//  Created by GREEN on 2023/06/08.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    // 1
//    PhaseAnimatorView1()
    
    // 2
//    PhaseAnimatorView2()
    
    // 3
    KeyframesView()
  }
}

// MARK: - PhaseAnimtor View (1)
private struct PhaseAnimatorView1: View {
  var xcodeImage: Image = Image("XcodeImage")
  @State private var selected: Bool = false
  
  var body: some View {
    VStack(spacing: 30) {
      xcodeImage
        .scaleEffect(selected ? 1.5 : 1.0)
        .onTapGesture {
          withAnimation {
            selected.toggle()
          }
        }
      
      Text("Xcode")
        .font(.title)
    }
    .phaseAnimator(
      [false, true],
      trigger: selected
    ) { content, phase in
      content
        .foregroundStyle(phase ? .red : .green)
    } animation: { phase in
        .spring
    }
  }
}

// MARK: - PhaseAnimtor View (2)
private struct PhaseAnimatorView2: View {
  var xcodeImage: Image = Image("XcodeImage")
  
  @State private var selected: Bool = false
  
  var body: some View {
    xcodeImage
      .onTapGesture {
        withAnimation {
          selected.toggle()
        }
      }
      .phaseAnimator(
        Phase.allCases,
        trigger: selected
      ) { content, phase in
        content
          .scaleEffect(phase.scale)
          .offset(y: phase.verticalOffset)
      } animation: { phase in
        switch phase {
        case .initial: .smooth
        case .move: .easeInOut(duration: 0.3)
        case .scale: .spring(
          duration: 0.3,
          bounce: 0.7
        )
        }
      }
  }
}

enum Phase: CaseIterable {
  case initial
  case move
  case scale
  
  var verticalOffset: Double {
    switch self {
    case .initial:
      return 0
    case .move:
      return -100
    case .scale:
      return -100
    }
  }
  
  var scale: Double {
    switch self {
    case .initial:
      return 1.0
    case .move:
      return 1.0
    case .scale:
      return 2.0
    }
  }
}

// MARK: - Keyframes
private struct KeyframesView: View {
  var xcodeImage: Image = Image("XcodeImage")
  
  @State private var selected: Bool = false
  
  let key = KeyframeTimeline(initialValue: AnimationValues()) {
    KeyframeTrack(\.scale) {
      LinearKeyframe(1.0, duration: 0.5)
      SpringKeyframe(1.5, duration: 0.8, spring: .bouncy)
      SpringKeyframe(1.0, spring: .bouncy)
    }
  }
  
  var body: some View {
    xcodeImage
      .onTapGesture {
        withAnimation {
          selected.toggle()
        }
      }
      .keyframeAnimator(
        initialValue: AnimationValues(),
        trigger: selected
      ) { content, value in
        content
          .rotationEffect(value.angle)
          .scaleEffect(value.scale)
          .scaleEffect(y: value.verticalStretch)
          .offset(y: value.verticalTranslation)
      } keyframes: { _ in
        KeyframeTrack(\.scale) {
          LinearKeyframe(1.0, duration: 0.5)
          SpringKeyframe(1.5, duration: 0.8, spring: .bouncy)
          SpringKeyframe(1.0, spring: .bouncy)
        }
        
        KeyframeTrack(\.verticalStretch) {
          LinearKeyframe(1.0, duration: 0.5)
          SpringKeyframe(1.5, duration: 0.8, spring: .bouncy)
          SpringKeyframe(1.0, spring: .bouncy)
        }
        
        KeyframeTrack(\.verticalTranslation) {
          LinearKeyframe(1.0, duration: 0.5)
          SpringKeyframe(1.5, duration: 0.8, spring: .bouncy)
          SpringKeyframe(1.0, spring: .bouncy)
        }
        
        KeyframeTrack(\.angle) {
          LinearKeyframe(.degrees(90), duration: 0.5)
          SpringKeyframe(.degrees(180), duration: 0.8, spring: .bouncy)
          SpringKeyframe(.degrees(0), spring: .bouncy)
        }
      }
  }
}

struct AnimationValues {
  var scale = 1.0
  var verticalStretch = 1.0
  var verticalTranslation = 0.0
  var angle = Angle.zero
}


#Preview {
  ContentView()
}
