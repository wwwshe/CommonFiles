//
//  RealmManager.swift
//  DDota
//
//  Created by jungwook on 2019/12/10.
//  Copyright © 2019 jungwook. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager{
    static let shared = RealmManager()
    
    let networking = NetworkManager.shared
    
    var isHaveLineData : Bool{
        get{
            let realm = try! Realm()
            let obj = realm.objects(SubwayLineInfoElement.self)
            if obj.isEmpty{
                return false
            }else{
                return true
            }
        }
    }
    
    
    @discardableResult 
    func setLineDatas(idx : Int) -> SubwayLineInfo{
        let realm = try! Realm()
        let data = getLineDatas(idx: idx)
        let lineInfos = decodeSubwayLineInfo(data: data)
        let infos = lineInfos.sorted { (info1, info2) -> Bool in
            return info1.stationNm < info2.stationNm
        }
        
        try! realm.write {
            realm.add(infos, update: true)
        }
        return lineInfos
    }
    
    func getLineDatas(idx : Int) -> Data{
        let url = "\(OPEN_API_BASE_URL)\(OPEN_API_LINE_URL)\(TYPE_JSON)\(SUBWAY_LINE_INFO)/1/100/ / /0\((idx))호선"
        var returnData = Data()
        networking.requestSync(url: url, method : .get) { (result) in
            switch result{
            case .success(let data):
                returnData = data
            case .failure(let error):
                print(error)
            }
        }
        return returnData
    }
    
    func decodeSubwayLineInfo(data : Data) -> SubwayLineInfo{
        var lineInfos = SubwayLineInfo()
        
        let decoder = JSONDecoder()
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            let dic = json as! [String : Any]
            let topDic = dic["SearchSTNBySubwayLineInfo"] as! [String : Any]
            let result = topDic["RESULT"] as! [String : Any]
            let code = result["CODE"] as! String
            
            if code == OPEN_API_SUCCESE_CODE{
                let rows = topDic["row"] as Any
                let infoData = try JSONSerialization.data(withJSONObject: rows, options: .prettyPrinted)
                var datas = try decoder.decode(SubwayLineInfo.self, from: infoData)
                
                datas = datas.map { (sub) -> SubwayLineInfoElement in
                    var temp = sub
                    temp.stationNm += "역"
                    return temp
                }
                
                
                lineInfos = datas
            }
        } catch {
            DLogPrint("error : \(error)")
        }
        return lineInfos
    }
    
    func searchStation(name : String) -> SubwayLineInfo{
        let realm = try! Realm()
        let obj = realm.objects(SubwayLineInfoElement.self)
        let predicate = NSPredicate(format: "stationNm contains[c] %@", name)
        let filterResult = obj.filter(predicate)
        if !filterResult.isEmpty{
            var stations = Array(filterResult)
            stations = stations.sorted { (left, right) -> Bool in
                return left.stationNm < right.stationNm
            }
            return stations
        }else{
            return SubwayLineInfo()
        }
    }
    
}
