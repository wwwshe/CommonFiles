//
//  UIView+Extension.swift
//
//  Created by jun wook on 2020/02/18.
//  Copyright © 2020 ryuickhwan. All rights reserved.
//

import Foundation
import UIKit

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

