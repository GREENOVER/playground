//
//  ContentView.swift
//  monospacedDigit
//
//  Created by GREEN on 2023/07/20.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack(spacing: 20) {
      // 기본
      BasicView()
      
      // monospaced 적용
      MonospacedView()
      
      // monospacedDigit 적용
      MonospacedDigitView()
      
      // Font에서 monospaced 적용
      FontMonospacedView()
    }
  }
}

private struct BasicView: View {
  @State var num: Int = 100
  
  var body: some View {
    VStack(spacing: 10) {
      HStack {
        Text("Number is")
          .font(.system(size: 32))
        
        Spacer()
        
        Text("\(num)")
          .font(.system(size: 32))
          .border(.green)
        
      }
      .border(.red)
      .padding(.horizontal, 90)
      
      Button(
        action: {
          num = .random(in: 100...999)
        },
        label: {
          Text("Change Number")
        }
      )
    }
  }
}

private struct MonospacedView: View {
  @State var num: Int = 100
  
  var body: some View {
    VStack(spacing: 10) {
      HStack {
        Text("Number is")
          .font(.system(size: 32))
        
        Spacer()
        
        Text("\(num)")
          .font(.system(size: 32))
          .border(.green)
        
      }
      .border(.red)
      .padding(.horizontal, 70)
      .monospaced()
      
      Button(
        action: {
          num = .random(in: 100...999)
        },
        label: {
          Text("Change Number")
        }
      )
    }
  }
}

private struct MonospacedDigitView: View {
  @State var num: Int = 100
  
  var body: some View {
    VStack(spacing: 10) {
      HStack {
        Text("Number is")
          .font(.system(size: 32))
        
        Spacer()
        
        Text("\(num)")
          .font(.system(size: 32))
          .border(.green)
        
      }
      .border(.red)
      .padding(.horizontal, 70)
      .monospacedDigit()
      
      Button(
        action: {
          num = .random(in: 100...999)
        },
        label: {
          Text("Change Number")
        }
      )
    }
  }
}

private struct FontMonospacedView: View {
  @State var num: Int = 100
  
  var body: some View {
    VStack(spacing: 10) {
      HStack {
        Text("Number is")
          .font(.system(size: 32, design: .serif))
        
        Spacer()
        
        Text("\(num)")
          .font(.system(size: 32, design: .monospaced))
          .border(.green)
        
      }
      .border(.red)
      .padding(.horizontal, 70)
      
      Button(
        action: {
          num = .random(in: 100...999)
        },
        label: {
          Text("Change Number")
        }
      )
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
