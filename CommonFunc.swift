//
//  CommonFunc.swift
//  sample
//
//  Created by jungwook on 07/10/2019.
//  Copyright © 2019 jungwook. All rights reserved.
//

import Foundation
import UIKit

/*
 # Alert Message
 - parameter
    - viewConroller : Alert 팝업을 띄울 뷰컨트롤러
    - meesage : Alert 팝업의 메세지
 */
func alertMessage(viewConroller: UIViewController,meesage : String) {
    
    let alertController = UIAlertController(title: "알림",
                                            message: meesage,
                                            preferredStyle: .alert);
    let okAction = UIAlertAction(title: "확인",
                                 style: .default) { (result : UIAlertAction) -> Void in
    }
    alertController.addAction(okAction);
    viewConroller.present(alertController, animated: true, completion: nil);
}
