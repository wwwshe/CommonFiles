//
//  UINavigationController+Extension.swift
//  DDota
//
//  Created by jungwook on 2019/12/02.
//  Copyright © 2019 jungwook. All rights reserved.
//

import Foundation
import UIKit


extension UINavigationController {
   open override var preferredStatusBarStyle: UIStatusBarStyle {
      return topViewController?.preferredStatusBarStyle ?? .default
   }
}
