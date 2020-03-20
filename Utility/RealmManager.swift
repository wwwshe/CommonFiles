//
//  RealmManager.swift

//
//  Created by jungwook on 2019/12/10.
//  Copyright © 2019 jungwook. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager{
    static let shared = RealmManager()
    
    
    func setStationDatas(datas : StationDatas){
        let realm = try! Realm()
        do {
            try realm.write {
                realm.add(datas, update: .all)
            }
        } catch  {
            print("error : \(error)")
        }
    }
    
    func selectStation(frCode : String) -> StationData{
        let realm = try! Realm()
        let obj = realm.objects(StationData.self)
        let predicate = NSPredicate(format: "frCode = %@", frCode)
        let filterResult = obj.filter(predicate)

        if !filterResult.isEmpty{
            let stations = Array(filterResult)
            return stations[0]
        }else{
            return StationData()
        }
    }
}
