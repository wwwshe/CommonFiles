//
//  UIView+Extension.swift
//  CornerShadowSample
//
//  Created by jungwook on 2019/11/07.
//  Copyright © 2019 jungwook. All rights reserved.
//

import UIKit
//MARK: UIView Extension
extension UIView {
    
    func addBorderShadow(color:UIColor, opacity:Float = 0.5, edge:AIEdge, shadowSize:CGFloat)    {
        
        var rect : CGRect = .zero
        switch edge {
        case .Top:
            rect = CGRect(x: 0, y: -shadowSize, width: self.frame.width, height: shadowSize)
        case .Left:
            rect = CGRect(x: 0, y: 0, width: shadowSize, height: self.frame.height)
        case .Bottom:
            rect = CGRect(x: 0, y: self.frame.height, width: self.frame.width , height: shadowSize)
        case .Right:
            rect = CGRect(x: self.frame.width, y: 0, width: shadowSize , height: self.frame.height)
            
            
        case .Top_Left:
            rect = CGRect(x: -shadowSize, y: -shadowSize, width: self.frame.size.width - shadowSize, height: self.frame.size.height - shadowSize)
        case .Top_Right:
             rect = CGRect(x: shadowSize , y: -shadowSize , width: self.frame.size.width + shadowSize, height: self.frame.size.height)
        case .Bottom_Left:
             rect = CGRect(x: -shadowSize  , y: shadowSize, width: self.frame.size.width, height: self.frame.size.height + shadowSize)
        case .Bottom_Right:
            rect = CGRect(x: shadowSize , y: shadowSize, width: self.frame.size.width + shadowSize, height: self.frame.size.height + shadowSize)
            
            
        case .All:
            rect = CGRect(x: -shadowSize , y: -shadowSize, width: self.frame.size.width + (shadowSize * 2), height: self.frame.size.height + (shadowSize * 2))
        }
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = opacity
        let shadowPath = UIBezierPath(rect: rect)
        self.layer.shadowPath = shadowPath.cgPath
        
    }
}

enum AIEdge:Int {
    case
    Top,
    Left,
    Bottom,
    Right,
    Top_Left,
    Top_Right,
    Bottom_Left,
    Bottom_Right,
    All
}


extension UIView {
    func screenshot() -> UIImage {
        if #available(iOS 10.0, *) {
            let format = UIGraphicsImageRendererFormat()
            return UIGraphicsImageRenderer(size: bounds.size, format: format).image { _ in
                drawHierarchy(in: CGRect(origin: .zero, size: bounds.size), afterScreenUpdates: true)
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
            drawHierarchy(in: self.bounds, afterScreenUpdates: true)
            let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
            UIGraphicsEndImageContext()
            return image
        }
    }
}
