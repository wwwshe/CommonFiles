//
//  NetworkManager.swift
//
//
//  Created by jungwook on 2019/11/26.
//  Copyright © 2019 jungwook. All rights reserved.
//

import Foundation

enum NetworkError : Error{
    case RequestError
    case JSONParserError
}
extension NetworkError{
    var localizedDescription: String{
        var errorDescription = ""
        switch self {
        case .RequestError:
            errorDescription = "Request Fail"
        case .JSONParserError:
            errorDescription = "JSON Parsing Fail"
        }
        return "Error : \(errorDescription)"
    }
}

class NetworkManager : NSObject{
    static let shared = NetworkManager(baseURL: BASE_URL)
    var baseURL : String = ""
    lazy var urlSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    init(baseURL: String) {
        self.baseURL = baseURL;
        let configuration = URLSessionConfiguration.default;
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData;// NO-CHACHE
        configuration.timeoutIntervalForRequest = 10;
    }
    func requestVMInfo(path : String , compltion : @escaping (Result<VMInfo,NetworkError>) -> Void ){
        var request = URLRequest(url: URL(string: "\(baseURL)\(path)")!,
                                 timeoutInterval: 10.0)
        request.httpMethod = "POST"
        let tempData = #"[{"maj" : 60000, "min" : 30, "rssi" : -83, "rssiList" : [ -83, -82,-93]}]"#
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = tempData.data(using: .utf8)
        
        let dataTask = urlSession.dataTask(with: request as URLRequest, completionHandler: { (responseData, response, error) -> Void in
            guard let data = responseData else{
                print(error ?? "Error nil")
                return
            }
            let decoder = JSONDecoder()
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let dic = json as! [String : Any]
                let code = dic["code"] as! Int
                let vmInfo = dic["vminfo"] as! [String : Any]
                let vmInfoData = try JSONSerialization.data(withJSONObject: vmInfo, options: .prettyPrinted)
                if code == 200 {
                    let decodeData = try decoder.decode(VMInfo.self, from: vmInfoData)
                    compltion(.success(decodeData))
                }else{
                    compltion(.failure(.RequestError))
                }
            } catch {
                compltion(.failure(.JSONParserError))
            }
        })
        dataTask.resume()
    }
    
}

extension NetworkManager : URLSessionDelegate{
    
}
