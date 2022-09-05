//
//  LoginView.swift
//  FocusState
//
//  Created by GREEN on 2022/09/05.
//

import SwiftUI

struct LoginView: View {
  @State var name: String = ""
  @State var password = ""
  @FocusState var focusField: Field?
  
  var body: some View {
    Form {
      TextField("Name", text: $name)
        .focused($focusField, equals: .name)
        .onSubmit {
          focusField = .password
        }
      TextField("Password", text: $password)
        .focused($focusField, equals: .password)
        .onSubmit {
          checkTextFiled()
        }
      Button("Login") {
        checkTextFiled()
      }
    }
//    .uiKitOnAppear {
//      focusField = .name
//    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
        focusField = .name
      }
    }
  }
  
  private func checkTextFiled() {
    if name.isEmpty {
      focusField = .name
    } else if password.isEmpty {
      focusField = .password
    } else {
      focusField = nil
      // 로그인 처리 로직 🙌
    }
  }
}

enum Field: Hashable {
  case name
  case password
}


// MARK: - UIKit 방식으로 onAppear 시 초기값 제공
struct UIKitAppear: UIViewControllerRepresentable {
  let action: () -> Void
  func makeUIViewController(context: Context) -> UIAppearViewController {
    let vc = UIAppearViewController()
    vc.action = action
    return vc
  }
  func updateUIViewController(_ controller: UIAppearViewController, context: Context) {
  }
}

class UIAppearViewController: UIViewController {
  var action: () -> Void = {}
  override func viewDidLoad() {
    view.addSubview(UILabel())
  }
  override func viewDidAppear(_ animated: Bool) {
    // had to delay the action to make it work.
    DispatchQueue.main.asyncAfter(deadline:.now()) { [weak self] in
      self?.action()
    }
    
  }
}

public extension View {
  func uiKitOnAppear(_ perform: @escaping () -> Void) -> some View {
    self.background(UIKitAppear(action: perform))
  }
}
