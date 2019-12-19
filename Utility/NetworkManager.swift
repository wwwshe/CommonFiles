//
//  NetworkManager.swift
//  DDota
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
    func request(body : Data = Data() , url : String, method : HttpMethod = .post , compltion : @escaping (Result<Data,NetworkError>) -> Void ){
        if let encoded  = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let myURL = URL(string: encoded){
            var request = URLRequest(url: myURL,
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
        
    }
    func request(body : Data = Data() , url : URL, method : HttpMethod = .post , compltion : @escaping (Result<Data,NetworkError>) -> Void ){
        var request = URLRequest(url: url,
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
    func requestSync(body : Data = Data() , url : String ,method : HttpMethod = .post, compltion : @escaping (Result<Data,NetworkError>) -> Void ){
        let semaphore = DispatchSemaphore(value: 0)
        if let encoded  = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let myURL = URL(string: encoded){
            var request = URLRequest(url: myURL,
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
        }
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
    }
    func requestSync(body : Data = Data() , url : URL ,method : HttpMethod = .post, compltion : @escaping (Result<Data,NetworkError>) -> Void ){
        let semaphore = DispatchSemaphore(value: 0)
            var request = URLRequest(url: url,
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
    
    func requestXMLSync(body : Data = Data() , url : URL ,method : HttpMethod = .post, compltion : @escaping (Result<Data,NetworkError>) -> Void ){
        let semaphore = DispatchSemaphore(value: 0)
            var request = URLRequest(url: url,
                                     timeoutInterval: 10.0)
            request.httpMethod = method.rawValue
            request.setValue("application/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
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
    func requestXML(body : Data = Data() , url : URL ,method : HttpMethod = .post, compltion : @escaping (Result<Data,NetworkError>) -> Void ){
               var request = URLRequest(url: url,
                                        timeoutInterval: 10.0)
               request.httpMethod = method.rawValue
               request.setValue("application/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
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
}

extension NetworkManager : URLSessionDelegate{
    
}
