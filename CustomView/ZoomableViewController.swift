//
//  ZoomableViewController.swift
//  DDota
//
//  Created by jungwook on 2019/12/03.
//  Copyright © 2019 jungwook. All rights reserved.
//

import UIKit

class ZoomableViewController: UIViewController, Zoomable, UIScrollViewDelegate {
    var zoomScrollView: UIScrollView = UIScrollView()
    
    var zoomImageView: UIImageView = UIImageView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return zoomImageView
    }
        
}
