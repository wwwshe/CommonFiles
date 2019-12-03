//
//  Zoomable.swift
//  DDota
//
//  Created by jungwook on 2019/12/03.
//  Copyright © 2019 jungwook. All rights reserved.
//

import Foundation
import UIKit

protocol Zoomable : UIScrollViewDelegate where Self : UIViewController {
    var zoomScrollView : UIScrollView {get set}
    var zoomImageView : UIImageView  {get set}
}
extension Zoomable {
    func scrollViewSetting(view : UIView){
        let frameGuide = zoomScrollView.frameLayoutGuide
        let contentGuide = zoomScrollView.contentLayoutGuide
        zoomScrollView.alwaysBounceVertical = false
        zoomScrollView.alwaysBounceHorizontal = false
        zoomScrollView.minimumZoomScale = 1.0
        zoomScrollView.maximumZoomScale = 5.0
        
        zoomImageView.image = view.screenshot()
        
        zoomScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        zoomImageView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        NSLayoutConstraint.activate([
            zoomImageView.topAnchor.constraint(equalTo: contentGuide.topAnchor,constant: 0),
            zoomImageView.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor,constant: 0),
            zoomImageView.bottomAnchor.constraint(equalTo: contentGuide.bottomAnchor,constant: 0),
            zoomImageView.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor,constant: 0),
            
            zoomImageView.centerXAnchor.constraint(equalTo: frameGuide.centerXAnchor),
            zoomImageView.centerYAnchor.constraint(equalTo: frameGuide.centerYAnchor),
            
            zoomScrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 0),
            zoomScrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 0),
            zoomScrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant: 0),
            zoomScrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: 0)
        ])
              
        zoomScrollView.delegate = self
    }
    func setZoomEnable(enable : Bool, view : UIView){
        if enable{
            zoomScrollView.addSubview(zoomImageView)
            self.view.addSubview(zoomScrollView)
            scrollViewSetting(view : view)
            view.isHidden = true
            
        }else{
            zoomImageView.removeFromSuperview()
            zoomScrollView.removeFromSuperview()
            view.isHidden = false
        }
        
    }
   
    
    
}
