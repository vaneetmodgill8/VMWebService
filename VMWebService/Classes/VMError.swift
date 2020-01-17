//
//  VMError.swift
//  VMWebService
//
//  Created by Vaneet Modgill on 17/12/19.
//

import Foundation

public struct VMError {
    public var error: Error
    public var code: Int?
    public var description: String?
    
    public init(_ error: Error) {
        self.error = error
    }
    
    public init(_ error: Error, code: Int? = nil, description: String? = nil) {
        self.error = error
        self.code = code
        self.description = description
    }
}

