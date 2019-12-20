//
//  Application.swift
//  DDota
//
//  Created by jungwook on 2019/11/25.
//  Copyright © 2019 jungwook. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Unrealm
import AVFoundation
import Speech

final class Application{
    static let shared = Application()
    
    enum ApplicationState{
        case none
        case inStation
        case inSubway
        case byTransfer
        case exitSubway
    }
    
    var applicationState = ApplicationState.none
    
    var userDefaults = UserDefaults.standard
    var isRouteGuide = false{
        didSet{
            notificationPost(ROUTE_GUIDE_CHANGE)
        }
    }
    
    var isGuide: Bool {
        get{
            return userDefaults.bool(forKey: IS_GUIDE)
        }set{
            setUserDefaultValue(key: IS_GUIDE, value: newValue)
        }
    }
    var networkManager = NetworkManager.shared
  
    func setUserDefaultValue(key : String, value : Any){
        userDefaults.set(value, forKey: key)
    }
    func getUserDefaultValue<T>(key : String, type : T.Type) -> T?{
        guard let value = userDefaults.value(forKey: key) else{
            return nil
        }
        return value as? T
    }
    
 
    func applicationSetting(){
        Realm.Configuration.defaultConfiguration = Realm.Configuration(
                   schemaVersion: REALM_VERSION,
                   migrationBlock: { migration, oldSchemaVersion in
                       if (oldSchemaVersion < REALM_VERSION) {
                          //write the migration logic here
              
                       }
               })
        Realm.registerRealmables(SubwayLineInfoElement.self)
        createStationRealm()
    }
   
    func createStationRealm(){
        let realmManager = RealmManager()
        if !realmManager.isHaveLineData{
            for i in 1..<9{
                realmManager.setLineDatas(idx: i)
            }
        }
    }
    

    
    /// Notification Post
    /// - Parameter name: Notification Name
    func notificationPost(_ name : String){
        NotificationCenter.default.post(name: Notification.Name(name), object: nil)
    }
    /// Notification Add
    /// - Parameters:
    ///   - controller: UIViewController
    ///   - selector: Notification Selector
    ///   - name: Notification Name
    func addNotificationObserver(controller : UIViewController, selector : Selector, name : String){
        NotificationCenter.default.addObserver(controller, selector: selector, name: Notification.Name(rawValue: name), object: nil)
    }
    /// Notification Remove
    /// - Parameters:
    ///   - controller: UIViewController
    ///   - name: Notification Name
    func removeNotificationObserver(controller : UIViewController, name : String){
        NotificationCenter.default.removeObserver(controller, name: Notification.Name(rawValue: name), object: nil)
    }

}

