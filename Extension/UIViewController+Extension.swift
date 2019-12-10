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

extension UIViewController {
    var isModal: Bool {
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
    var prevController: UIViewController?{
        get{
            let prev = self.presentingViewController
            if prev is UINavigationController{
                let navi = prev as! UINavigationController
                return navi.topViewController
            }else{
                return prev
            }
        }
    }
}
