//
//  SelfSizedTableView.swift
//  YapWork
//
//  Created by jungwook on 2019/10/29.
//  Copyright © 2019 YapCompany. All rights reserved.
//

import Foundation
import UIKit

protocol ContentFittingTableViewDelegate: UITableViewDelegate {
    func tableViewDidUpdateContentSize(_ tableView: UITableView)
}

class SelfSizedTableView: UITableView {
    
    override func reloadData() {
        super.reloadData()
        
        self.layoutIfNeeded()
    }
    override var contentSize: CGSize{
        didSet{
            invalidateIntrinsicContentSize()
            self.sizeToFit()
            
            if contentSize != oldValue {
                if let delegate = delegate as? ContentFittingTableViewDelegate {
                    delegate.tableViewDidUpdateContentSize(self)
                }
            }
        }
        
    }
    
    
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return contentSize
    }
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        self.layoutIfNeeded()
        return contentSize
    }
    
}
