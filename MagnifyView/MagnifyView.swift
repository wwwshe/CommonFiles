//  MagnifyView.swift
//  ZoomSample
//
//  Created by jungwook on 2019/11/18.
//  Copyright © 2019 jungwook. All rights reserved.
//
import UIKit

enum MagnifyType : String{
    case Rect = "rect"
    case Circle = "Circle"
}

class MagnifyView: UIView {

    var magnifyView: UIView!
    var touchPoint: CGPoint!
    var type = MagnifyType.Rect
    @IBInspectable var scale : CGFloat = 1.5
    
    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'shape' instead.")
    @IBInspectable var shapeName: String? {
        willSet {
            // Ensure user enters a valid shape while making it lowercase.
            // Ignore input if not valid.
            if let newShape = MagnifyType(rawValue: newValue?.lowercased() ?? "") {
                type = newShape
            }
        }
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit()
    {
        // Set border color, border width and corner radius of the magnify view
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 3
        switch type {
        case .Circle:
            self.layer.cornerRadius = self.frame.width / 2
            self.layer.masksToBounds = true
        case .Rect:
             self.layer.cornerRadius = 0
            self.layer.masksToBounds = false
        }
    }
    
    func setTouchPoint(pt: CGPoint)
    {
        touchPoint = pt
        self.center = CGPoint(x: pt.x, y: pt.y - 80)
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context!.translateBy(x: 1 * (self.frame.size.width * 0.5), y: 1 * (self.frame.size.height * 0.5))
        context!.scaleBy(x: scale, y: scale) // 1.5 is the zoom scale
        context!.translateBy(x: -1 * (touchPoint.x), y: -1 * (touchPoint.y))
        self.magnifyView.layer.render(in: context!)
    }

}
