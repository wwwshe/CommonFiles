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
        navBar.titleTextAttributes = [.foregroundColor: titleColor, .font : UIFont.systemFont(ofSize: 24)]
//        navBar.setTitleVerticalPositionAdjustment(3, for:.default)
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
    var rootController : UIViewController?{
        get{
            return UIApplication.shared.delegate!.window??.rootViewController
        }
    }
}


extension UIViewController {
    func showToast(message : String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
