//
//  RoundButton.swift
//  DDota
//
//  Created by jungwook on 2019/11/29.
//  Copyright © 2019 jungwook. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundButton : UIButton{
    var isRound = false {
        didSet{
            if self.isRound{
               layer.cornerRadius = self.frame.height / 2
            }else{
               layer.cornerRadius = 0
            }
        }
    }
    @IBInspectable var isRoundButton: Int = 0 {
        didSet{
            if self.isRoundButton == 0 {
                isRound = false
            }else{
                isRound = true
            }
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
           set {
               layer.borderWidth = newValue
           }
           get {
               return layer.borderWidth
           }
       }
       @IBInspectable var borderColor: UIColor? {
           set {
               guard let uiColor = newValue else { return }
               layer.borderColor = uiColor.cgColor
           }
           get {
               guard let color = layer.borderColor else { return nil }
               return UIColor(cgColor: color)
           }
       }
}
