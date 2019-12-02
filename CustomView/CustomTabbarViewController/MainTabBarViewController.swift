//
//  ViewController.swift
//  DDota
//
//  Created by jungwook on 2019/11/21.
//  Copyright © 2019 jungwook. All rights reserved.
//

import UIKit


class MainTabBarViewController: ViewControllerHelper {
    @IBOutlet weak var locationBtn: UIButton!
    @IBOutlet weak var routeBtn: UIButton!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tabView: UIView!
    var viewControllers = [UIViewController]()
    var selectIdx : Int = 0{
        willSet{
            preSelectIdx = self.selectIdx
        }
        didSet{
            selectTabAction()
        }
    }
    var preSelectIdx = -1
    
    var tabs = [UIButton]()
    var selectBgColor = UIColor.black
    var unSelectBgColor = UIColor.clear
    
    var selectTitleColor = UIColor(netHex: 0xf7f800)
    var unSelectTitleColor = UIColor.black
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initView()
        
        selectTabAction()
    }
    
    func initView(){
        let locationController = getViewController(target: LocationInfoViewController.self, storyboardType: .location)
        let locationNavi = UINavigationController(rootViewController: locationController)
        viewControllers.append(locationNavi)
        
        let routeController = getViewController(target: RouteInfoViewController.self, storyboardType: .route)
        let routeNavi = UINavigationController(rootViewController: routeController)
        viewControllers.append(routeNavi)
        
        tabs.append(locationBtn)
        tabs.append(routeBtn)
        
    }
    
    @IBAction func locationTabAction(_ sender: Any) {
        selectIdx = 0
       
    }
    @IBAction func routeTabAction(_ sender: Any) {
        selectIdx = 1
        
    }
    
    func selectTabAction(){
        if preSelectIdx > -1 {
            let previousVC = viewControllers[preSelectIdx]
            previousVC.willMove(toParent: nil)
            previousVC.view.removeFromSuperview()
            previousVC.removeFromParent()
            
            tabs[preSelectIdx].backgroundColor = unSelectBgColor
            tabs[preSelectIdx].setTitleColor(unSelectTitleColor, for: .normal)
        }
        tabs[selectIdx].backgroundColor = selectBgColor
        tabs[selectIdx].setTitleColor(selectTitleColor, for: .normal)
        
        self.addChild(viewControllers[selectIdx])
        viewControllers[selectIdx].view.frame = self.mainView.bounds
        self.mainView.addSubview(viewControllers[selectIdx].view)
        viewControllers[selectIdx].didMove(toParent: self)
    }
    
}

