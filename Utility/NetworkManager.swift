//
//  NetworkManager.swift

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

enum HttpMethod : String{
    case get
    case post
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
    func request(body : Data = Data() , path : String, method : HttpMethod = .post , compltion : @escaping (Result<Data,NetworkError>) -> Void ){
        
        var request = URLRequest(url: URL(string: "\(baseURL)\(path)")!,
                                 timeoutInterval: 10.0)
        request.httpMethod = method.rawValue
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        let dataTask = urlSession.dataTask(with: request as URLRequest, completionHandler: { (responseData, response, error) -> Void in
            guard let data = responseData else{
                compltion(.failure(.RequestError))
                return
            }
     
            compltion(.success(data))
        })
        dataTask.resume()
    }
    func requestSync(body : Data = Data() , path : String ,method : HttpMethod = .post, compltion : @escaping (Result<Data,NetworkError>) -> Void ){
        let semaphore = DispatchSemaphore(value: 0)
        var request = URLRequest(url: URL(string: "\(baseURL)\(path)")!,
                                 timeoutInterval: 10.0)
        request.httpMethod = method.rawValue
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        let dataTask = urlSession.dataTask(with: request as URLRequest, completionHandler: { (responseData, response, error) -> Void in
            guard let data = responseData else{
                compltion(.failure(.RequestError))
                semaphore.signal()
                return
            }
            compltion(.success(data))
            semaphore.signal()
        })
        dataTask.resume()
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
    }
    
    
}

extension NetworkManager : URLSessionDelegate{
    
}
