//
//  UIViewController+Extension.swift
//  DDota
//
//  Created by jungwook on 2019/12/02.
//  Copyright © 2019 jungwook. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func setupNavigationBarBackground(navBar: UINavigationBar, bgColor : UIColor, titleColor : UIColor) {
        navBar.isTranslucent = false
        let navBarColorImage = bgColor.image()
        navBar.setBackgroundImage(navBarColorImage, for: .default)
        navBar.tintColor = UIColor.white
        navBar.titleTextAttributes = [.foregroundColor: titleColor]
    }
    
}

