//
//  File.swift
//  VMServiceAPI
//
//  Created by vaneetmodgill@gmail.com on 07/11/19.
//

import Foundation
import ObjectiveC

public class VMWebServiceComponent {
   public var api:VMWebServiceApi?
   public var configurator: VMWebServiceConfiguratorClient?
   public init() {}
}

public protocol HasWebServiceComponent {
    var webServiceComponent: VMWebServiceComponent { get set }
}

public protocol VMWebService: class , HasWebServiceComponent{
    
    func bodyParameters() -> [String:Any]?
    func headerParameters() -> [String:String]?
    func url() -> String
    func requestTimeOut()->Int
    func validalidatorClient() -> VMResultValidatorApi?
    func methodType() -> VMMethodType
    func encodingType() -> VMURLEncodingType
    func resultType() -> VMResultType
    
    func apiCall(_ completionHandler: @escaping (Result<VMWSResponse, VMWebServiceError>) -> Void)
    func cancel()
    func cancelAll()
    
}


extension VMWebService{
    
    var configurator: VMWebServiceConfiguratorClient! {
         get { return webServiceComponent.configurator }
         set { webServiceComponent.configurator = newValue }
     }
    
       var api: VMWebServiceApi! {
             get { return webServiceComponent.api }
            set { webServiceComponent.api = newValue }
        }
    
    
    public func bodyParameters()->[String:Any]?{
        return nil
    }
    
    public func headerParameters()->[String:String]?{
        return nil
    }
    
    public func requestTimeOut()->Int{
        return 60
    }
    
    public func apiClient() -> VMWebServiceApi{
        return VMWebServiceApiDefault()
    }
    
    public func validalidatorClient() -> VMResultValidatorApi?{
        return nil
    }
    
    public func methodType()-> VMMethodType{
        return .GET
    }
    
    public func encodingType()-> VMURLEncodingType{
        return .QUERY
    }
    
    public func resultType() -> VMResultType{
        return .String
    }
    
    public func apiCall(_ completionHandler: @escaping (Result<VMWSResponse, VMWebServiceError>) -> Void){
        configurator = VMWebServiceConfiguratorClient()
        configurator.dataSource = self
        let result = configurator.createRequest()
        switch result {
            case .success(let webServiceRequest):
                api = configurator.getApi()
                initiateApiCall(webServiceRequest, completionHandler: completionHandler)
            
            case .failure(let error):
                completionHandler(Result.failure(error))
        }
    }
    
    public func cancel(){
        api.cancel()
    }
    
    public func cancelAll(){
        api.cancelAll()
    }
    
    
    public func initiateApiCall(_ request: VMWebServiceRequest, completionHandler: @escaping (Result<VMWSResponse, VMWebServiceError>) -> Void){
        api.call(request) {[weak self] (result) in
            let validator = self?.configurator.getValidator()
            if validator == nil{
                completionHandler(result)
                return
            }
            switch result {
            case .success(let wsResult):
                let validResult = validator?.validateResponse(wsResult)
                if let finalResult = validResult{
                    completionHandler(finalResult)
                }
                else{
                    completionHandler(Result.failure(.validatorApiFailed))
                }
            case .failure(let error):
                completionHandler(Result.failure(error))
            }
        }
    }


}



