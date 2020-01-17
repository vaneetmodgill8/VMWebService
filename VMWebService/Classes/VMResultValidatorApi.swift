//
//  ResponseValidatorApi.swift
//  VMServiceAPI
//
//  Created by vaneetmodgill@gmail.com on 13/11/19.
//

import Foundation

public protocol VMResultValidatorApi{
    func validateResponse(_ result: VMWSResponse) -> Result<VMWSResponse, VMWebServiceError>
}
