//
//  UIColor+Extension.swift
//  DDota
//
//  Created by jungwook on 2019/11/21.
//  Copyright © 2019 jungwook. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
   static var customCyan : UIColor{
        get{
            return UIColor(red: 26, green: 235, blue: 255)
        }
    }
    static var customGreen : UIColor{
        get{
            return UIColor(red: 63, green: 242, blue: 63)
        }
    }
    static var customYellow : UIColor{
        get{
            return UIColor(red: 247, green: 248, blue: 0)
        }
    }
}

