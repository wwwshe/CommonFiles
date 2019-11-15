//
//  StoryboardLoadHelper.swift
//  TabGestureSample
//
//  Created by jungwook on 2019/11/15.
//  Copyright © 2019 jungwook. All rights reserved.
//

import UIKit

typealias ViewControllerHelper = UIViewController & ViewControllerLoadHelper

enum StoryboardType : String {
    case main = "Main"
    case temp = "Temp"
}
extension UIStoryboard {
    static func getStoryBoard(type : StoryboardType = .main) -> UIStoryboard{
        return UIStoryboard(name: type.rawValue, bundle: nil)
    }
}
protocol ViewControllerLoadHelper{
    func getViewController<T : UIViewController>(target : T.Type, storyboardType type : StoryboardType) -> T
}
extension ViewControllerLoadHelper{
    func getViewController<T : UIViewController>(target : T.Type, storyboardType type : StoryboardType = .main) -> T{
            var storyBoard : UIStoryboard
            storyBoard = UIStoryboard.getStoryBoard(type: type)
            let identifier = String(describing: target)
            let identifiersList = storyBoard.value(forKey: "identifierToNibNameMap") as? [String: Any]
            guard ((identifiersList?[identifier]) != nil) else{
                print("UIViewController identifier not found, identifier : \(identifier)")
                return target.init()
            }
            var viewcontroller : UIViewController
            if #available(iOS 13.0, *){
                viewcontroller = storyBoard.instantiateViewController(identifier: identifier)
            }else{
                viewcontroller = storyBoard.instantiateViewController(withIdentifier: identifier)
            }
            let selfViewController = viewcontroller as! T
            return selfViewController
        }
}
