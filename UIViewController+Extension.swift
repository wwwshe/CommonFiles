//
//  UIViewController+Extention.swift
//  TabGestureSample
//
//  Created by jungwook on 2019/11/12.
//  Copyright © 2019 jungwook. All rights reserved.
//

import UIKit
//MARK: UIStoryboard Type
enum StoryboardType : String {
    case main = "Main"
    case temp = "Temp"
}
//MARK: UIStoryboard Extension
extension UIStoryboard {
    static func getStoryBoard(type : StoryboardType = .main) -> UIStoryboard{
        return UIStoryboard(name: type.rawValue, bundle: nil)
    }
}
//MARK: UIViewController Extension
extension UIViewController{
    // UIViewController Identifier를 클래스 이름으로 동일하게 했을시 동작
    static func shared(storyboardType type : StoryboardType = .main) -> Self{
        var storyBoard : UIStoryboard
        storyBoard = UIStoryboard.getStoryBoard(type: type)
        let identifier = String(describing: self)
        let identifiersList = storyBoard.value(forKey: "identifierToNibNameMap") as? [String: Any]
        guard ((identifiersList?[identifier]) != nil) else{
            print("UIViewController identifier not found")
            return self.init()
        }
        var viewcontroller : UIViewController
        if #available(iOS 13.0, *){
            viewcontroller = storyBoard.instantiateViewController(identifier: String(describing: self))
        }else{
            viewcontroller = storyBoard.instantiateViewController(withIdentifier: String(describing: self))
        }
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
