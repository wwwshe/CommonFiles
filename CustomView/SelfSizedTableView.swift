//
//  SelfSizedTableView.swift
//  YapWork
//
//  Created by jungwook on 2019/10/29.
//  Copyright © 2019 YapCompany. All rights reserved.
//

import Foundation
import UIKit

class SelfSizedTableView: UITableView {
    
    override func reloadData() {
        super.reloadData()
        self.layoutIfNeeded()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
        print("contentsize : \(contentSize)")
        let height = floor(contentSize.height)
        return CGSize(width: contentSize.width, height: CGFloat(height))
    }
}
