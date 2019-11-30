//
//  CheckButton.swift
//  BirdView
//
//  Created by jun wook on 2019/11/30.
//  Copyright © 2019 jun wook. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CheckButton: UIButton {
    @IBInspectable
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.backgroundColor = .blue
            } else {
                self.backgroundColor = .white
            }
        }
    }
    var delegate : CheckButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setting()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setting()
    }
    
    func setting(){
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.borderWidth = 1
    }
    
    override func awakeFromNib() {
        setting()
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
            delegate?.changeState(check: isChecked)
        }
    }
}

protocol CheckButtonDelegate {
    func changeState(check : Bool)
}
