//
//  LineSpacingLabel.swift

//
//  Created by jungwook on 2019/11/25.
//  Copyright © 2019 jungwook. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class LineSpacingLabel : UILabel{
    
    @IBInspectable
    var lineSpace : Int = 0{
        didSet{
            setLineSpace()
        }
    }
    override var text : String?{
        didSet{
            setLineSpace()
        }
    }
    
    func setLineSpace(){
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = CGFloat(lineSpace)
        paragraphStyle.lineHeightMultiple = 1
        paragraphStyle.alignment = self.textAlignment
        
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        // (Swift 4.2 and above) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
     
        self.attributedText = attributedString
    }
    
    
    
}
