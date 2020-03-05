//
//  ViewControllerUtil.swift
//
//  Created by jun wook on 2020/03/05.
//  Copyright © 2020 jun wook. All rights reserved.
//

import Foundation
import UIKit

public class ViewControllerUtil{
    func getViewController<T : UIViewController>(target : T.Type, storyboardName name : String = "Main") -> T?{
        let storyBoard = UIStoryboard(name: name, bundle: nil)
        let identifier = String(describing: target)
        let identifiersList = storyBoard.value(forKey: "identifierToNibNameMap") as? [String: Any]
        guard ((identifiersList?[identifier]) != nil) else{
            print("UIViewController identifier not found, identifier : \(identifier)")
            return nil
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
    
    
    /// AlertMessage 띄우기
    /// - Parameters:
    ///   - viewConroller: 알럿띄울 뷰컨트롤러
    ///   - title: 타이틀 메세지 default : "알림"
    ///   - message: 알럿 메세지
    ///   - okAction: ok버튼 액션
    func alertMessage(viewConroller: UIViewController,title : String = "알림",message : String, okAction : UIAlertAction) {
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert);
        alertController.addAction(okAction);
        viewConroller.present(alertController, animated: true, completion: nil);
    }
    
}
