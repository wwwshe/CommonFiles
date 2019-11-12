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
    @nonobjc class var main: UIStoryboard {
        return UIStoryboard(name: StoryboardType.main.rawValue, bundle: nil)
    }
    //  @nonobjc class var journey: UIStoryboard {
    //    return UIStoryboard(name: StoryboardType.login.rawValue, bundle: nil)
    //  }
    //  @nonobjc class var quiz: UIStoryboard {
    //    return UIStoryboard(name: StoryboardType.profile.rawValue, bundle: nil)
    //  }
    //  @nonobjc class var home: UIStoryboard {
    //    return UIStoryboard(name: StoryboardType.home.rawValue, bundle: nil)
    //  }
}

extension UIViewController{
    //MARK: UIViewController Identifier를 클래스 이름으로 동일하게 했을시 동작
    static func shared(storyboardType type : StoryboardType = .main) -> Self?{
        var storyBoard : UIStoryboard
        
        switch type {
        case .main:
            storyBoard = UIStoryboard.main
        }
        
        let identifier = String(describing: self)
        let identifiersList = storyBoard.value(forKey: "identifierToNibNameMap") as? [String: Any]
        guard ((identifiersList?[identifier]) != nil) else{
            print("UIViewController identifier not found")
            return nil
        }
        let viewcontroller = storyBoard.instantiateViewController(identifier: String(describing: self))
        let selfViewController = viewcontroller as! Self
        return selfViewController
    }
}
