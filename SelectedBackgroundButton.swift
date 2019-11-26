//
//  SelectedButton.swift
//  DDota
//
//  Created by jungwook on 2019/11/25.
//  Copyright © 2019 jungwook. All rights reserved.
//

import Foundation
import UIKit

class SelectedBackgroundButton : UIButton{
    @IBInspectable var highlightedBackgroundColor :UIColor?
    @IBInspectable var nonHighlightedBackgroundColor :UIColor?
    override var isHighlighted :Bool {
        get {
            return super.isHighlighted
        }
        set {
            if newValue {
                self.backgroundColor = highlightedBackgroundColor
            }
            else {
                self.backgroundColor = nonHighlightedBackgroundColor
            }
            super.isHighlighted = newValue
        }
    }
    
    
}
