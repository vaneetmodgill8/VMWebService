//
//  WebServiceConfigurator.swift
//  VMServiceAPI
//
//  Created by vaneetmodgill@gmail.com on 09/11/19.
//

import Foundation
import UIKit
public protocol VMWebServiceConfigurator{
    var dataSource: VMWebService? {set get}
    func createRequest() -> Result<VMWebServiceRequest,VMWebServiceError>
}

public struct VMWebServiceConfiguratorClient: VMWebServiceConfigurator{
    
    public init(){}
    
    public weak var dataSource: VMWebService?
    
    public func createRequest() -> Result<VMWebServiceRequest, VMWebServiceError>{
        if dataSource == nil{
            return Result.failure(.requestGenerationFailed)
        }
        if !isUrlVerified(urlString: dataSource?.url()){
            return Result.failure(.invalidUrl)
        }
        if VMReachability.init()?.currentReachabilityStatus == .notReachable{
            return Result.failure(.networkNotReachable)
        }
        var request = VMWebServiceRequest()
        request.methodType = (dataSource?.methodType())!
        request.urlEncodingType = (dataSource?.encodingType())!
        request.url = (dataSource?.url())!
        request.parameters = dataSource?.bodyParameters()
        request.headers = dataSource?.headerParameters()
        request.timeOutSession = (dataSource?.requestTimeOut())!
        request.resultType = (dataSource?.resultType())!
        
        return Result.success(request)
    }
    
    public func validateResult(_ result: VMWSResponse) -> Result<VMWSResponse, VMWebServiceError>{
        if dataSource == nil{
            return Result.failure(.resultValidationFailed)
        }
        let resultValidatorAPI = dataSource?.validalidatorClient()
        if resultValidatorAPI != nil{
             return (resultValidatorAPI?.validateResponse(result))!
        }
        return Result.success(result)
        
    }
    
    public func getApi()-> VMWebServiceApi{
        return (dataSource?.apiClient())!
    }
    
    public func getValidator()-> VMResultValidatorApi?{
        return dataSource?.validalidatorClient()
    }
    
    private func isUrlVerified (urlString: String?) -> Bool {
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
            if let url = URL.init(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.shared.canOpenURL(url)
            }
        }
        return false
    }
}

