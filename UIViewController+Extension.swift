//
//  UIViewController+Extention.swift
//  TabGestureSample
//
//  Created by jungwook on 2019/11/12.
//  Copyright © 2019 jungwook. All rights reserved.
//

import UIKit

enum StoryboardType : String {
    case main = "Main"
}
extension UIStoryboard {
    static func getStoryBoard(type : StoryboardType = .main) -> UIStoryboard{
        switch type {
        case .main:
            return UIStoryboard(name: StoryboardType.main.rawValue, bundle: nil)
        }
    }
}

extension UIViewController{
    //MARK: UIViewController Identifier를 클래스 이름으로 동일하게 했을시 동작
    static func shared(storyboardType type : StoryboardType = .main) -> Self{
        var storyBoard : UIStoryboard
        
        switch type {
        case .main:
            storyBoard = UIStoryboard.getStoryBoard()
        }
        
        let identifier = String(describing: self)
        let identifiersList = storyBoard.value(forKey: "identifierToNibNameMap") as? [String: Any]
        guard ((identifiersList?[identifier]) != nil) else{
            print("UIViewController identifier not found")
            return self.init()
        }
        let viewcontroller = storyBoard.instantiateViewController(identifier: String(describing: self))
        let selfViewController = viewcontroller as! Self
        return selfViewController
    }
    
    func viewControllerPush<T : UIViewController>(viewController view : T, animate : Bool = true){
        guard let navi = self.navigationController else {
            print("Not use NavigationController")
            return
        }
        navi.pushViewController(view, animated: animate)
    }
    
}
