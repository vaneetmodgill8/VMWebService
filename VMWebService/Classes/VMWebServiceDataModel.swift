//
//  WebServiceDataModel.swift
//  VMServiceAPI
//
//  Created by vaneetmodgill@gmail.com on 09/11/19.
//

import Foundation

public enum VMMethodType {
    case GET
    case POST
    case PUT
    case DELETE
}

public enum VMURLEncodingType{
    case FORM
    case QUERY
    case JSONENCODING
    case FileUpload
}

public enum VMResultType{
    case String
    case Data
    case JSON
}

public enum VMWebServiceError:Error{
    case requestGenerationFailed
    case resultValidationFailed
    case networkNotReachable
    case validatorApiFailed
    case invalidUrl
    case apiError(vmError:VMError)
    case jsonConversionFailure
    case jsonParsingFailure
}

public struct VMWSResponse {
    public var request: VMWebServiceRequest?
    public var response: HTTPURLResponse?
    public var resultData: VMWSResult?
    
    public init(request: VMWebServiceRequest?, response: HTTPURLResponse?, resultData: VMWSResult?){
        self.request = request
        self.response = response
        self.resultData = resultData
    }
}


public protocol VMWSResult {}
extension String: VMWSResult{}
extension Data: VMWSResult{}
extension VMJson: VMWSResult{}

public struct VMJson {
    public var jsonData: AnyObject?
    public init(){}
}

public struct VMWebServiceRequest{
    public var methodType: VMMethodType = .GET
    public var urlEncodingType: VMURLEncodingType = .FORM
    public var url: String = ""
    public var parameters:[String:Any]?
    public var headers:[String:String]?
    public var resultType: VMResultType = .String
    public var timeOutSession = 60
}




