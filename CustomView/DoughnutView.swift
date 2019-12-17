//
//  DoughnutView.swift
//  DDota
//
//  Created by jungwook on 2019/12/13.
//  Copyright © 2019 jungwook. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class DoughnutView:UIView
{
   @IBInspectable var borderColor: UIColor = UIColor.white;

       @IBInspectable var borderSize: CGFloat = 4

       override func draw(_ rect: CGRect)
       {
           layer.borderColor = borderColor.cgColor
           layer.borderWidth = borderSize
           layer.cornerRadius = self.frame.height/2
       }
}
