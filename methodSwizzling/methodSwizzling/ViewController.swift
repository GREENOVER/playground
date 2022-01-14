//
//  ViewController.swift
//  methodSwizzling
//
//  Created by Chanwoo Cho on 2022/01/14.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

}

extension UIViewController {
  @objc dynamic func greenViewWillAppear(_ animated: Bool) {
    greenViewWillAppear(animated)
    
    print("Green's ViewWillAppear")
  }
  
  static func swizzleViewWillAppear() {
    let originalSelector = #selector(UIViewController.viewWillAppear(_:))
    let swizzledSelector = #selector(UIViewController.greenViewWillAppear(_:))
    
    let originalMethod = class_getInstanceMethod(UIViewController.self, originalSelector)!
    let swizzledMethod = class_getInstanceMethod(UIViewController.self, swizzledSelector)!
    
    method_exchangeImplementations(originalMethod, swizzledMethod)
  }
}

