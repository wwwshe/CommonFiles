//
//  CustomAlertViewController.swift
//  DDota
//
//  Created by jungwook on 2019/12/05.
//  Copyright © 2019 jungwook. All rights reserved.
//

import UIKit

class CustomAlertViewController: UIViewController {

    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var backView: UIView!
    
    var okString = "예"
    var cancelString = "아니요"
    var isOkOnly = false
    var okComplition : (() -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      setViews()
        setBlur()
        
    }
    func setViews(){
        okBtn.setTitle(okString, for: .normal)
        cancelBtn.setTitle(cancelString, for: .normal)
        
        okBtn.clipsToBounds = true
        okBtn.layer.cornerRadius = 10
        
        cancelBtn.clipsToBounds = true
        cancelBtn.layer.cornerRadius = 10
        cancelBtn.layer.maskedCorners = [.layerMinXMaxYCorner]
        if isOkOnly == true {
            cancelBtn.isHidden = true
            okBtn.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        }else{
            okBtn.layer.maskedCorners = [.layerMaxXMaxYCorner]
        }
        
        
        backView.layer.cornerRadius = 10
    }
    
    func setBlur(){
         let blurFx = UIBlurEffect(style: UIBlurEffect.Style.dark)
         let blurFxView = UIVisualEffectView(effect: blurFx)
         blurFxView.frame = view.bounds
         blurFxView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
         view.insertSubview(blurFxView, at: 0)
     }
     
    @IBAction func okAction(_ sender: Any) {
        self.dismiss(animated: false, completion: okComplition)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}
