//
//  WerbServiceApi.swift
//  VMServiceAPI
//
//  Created by vaneetmodgill@gmail.com on 09/11/19.
//

import Foundation


public protocol VMWebServiceApi{
    var request: VMWebServiceRequest? {get set}
    var response: AnyObject? {get set}
    mutating func call(_ request: VMWebServiceRequest, completionHandler: @escaping (Result<VMWSResponse, VMWebServiceError>) -> Void)
    func cancel()
    func cancelAll()
}

public struct VMWebServiceApiDefault: VMWebServiceApi {
    
    public init(){}
    
    public var request: VMWebServiceRequest?
    public var response: AnyObject?
    
    public mutating func call(_ request: VMWebServiceRequest, completionHandler: @escaping (Result<VMWSResponse, VMWebServiceError>) -> Void) {
        self.request = request
        
        
        let task = URLSession.shared.dataTask(with: URL(string: self.request!.url)!) { (data, response, error) in
                var description: String?
                              if response != nil{
                                description = String(data: data!, encoding: .utf8)
                              }
                              if description != nil{
                                  completionHandler(Result.success(VMWSResponse.init(request: request, response: nil, resultData: description)))
                              }else{
                                   completionHandler(Result.success(VMWSResponse.init(request: request, response: nil, resultData: "")))
                              }
        }
        task.resume()
        
     
    }
    
    public func cancel(){
        print("Pending url session feature needs to be added")
    }
    
    public func cancelAll(){
        print("Pending url session feature needs to be added")
    }
}
