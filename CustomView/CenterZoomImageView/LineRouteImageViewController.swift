//
//  LineRouteImageViewController.swift
//
//  Created by jungwook on 2019/11/22.
//  Copyright © 2019 jungwook. All rights reserved.
//

import UIKit

class LineRouteImageViewController: UIViewController {
    
    @IBOutlet weak var lineRouteImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollViewSetting()
        // Do any additional setup after loading the view.
        setNavigationBar()
    }
  
    
    func scrollViewSetting(){
        self.scrollView.alwaysBounceVertical = false
        self.scrollView.alwaysBounceHorizontal = false
        
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 8.0
        self.scrollView.delegate = self
    
    }
    func setNavigationBar(){
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}


extension LineRouteImageViewController : UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.lineRouteImageView
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
//        if scrollView.isZooming{
            if scrollView.zoomScale > 1 {

                if let image = lineRouteImageView.image {

                    let ratioW = lineRouteImageView.frame.width / image.size.width
                    let ratioH = lineRouteImageView.frame.height / image.size.height

                    let ratio = ratioW < ratioH ? ratioW:ratioH

                    let newWidth = image.size.width*ratio
                    let newHeight = image.size.height*ratio

                    let left = 0.5 * (newWidth * scrollView.zoomScale > lineRouteImageView.frame.width ? (newWidth - lineRouteImageView.frame.width) : (scrollView.frame.width - scrollView.contentSize.width))
                    let top = 0.5 * (newHeight * scrollView.zoomScale > lineRouteImageView.frame.height ? (newHeight - lineRouteImageView.frame.height) : (scrollView.frame.height - scrollView.contentSize.height))

                    scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
                }
            }else {
                scrollView.contentInset = UIEdgeInsets.zero
            }
//            let imageHeight = lineRouteImageView.frame.height < 270 ? 270 :  lineRouteImageView.frame.height
//            let screenHeight = UIScreen.main.bounds.height
//            let divY = (screenHeight / 2 - 135)  - (imageHeight - 270) - 44
//            let scrollViewY =  divY > 0 ? divY : 0
//
//            if imageHeight < screenHeight{
//                scrollView.frame = CGRect(x: 0, y: scrollViewY, width: scrollView.frame.width, height: imageHeight)
//            }
//        }
    }
    
}
