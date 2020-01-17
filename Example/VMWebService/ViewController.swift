//
//  ViewController.swift
//  VMWebService
//
//  Created by vaneetmodgill@gmail.com on 12/17/2019.
//  Copyright (c) 2019 vaneetmodgill@gmail.com. All rights reserved.
//

import UIKit
import VMWebService

class ViewController: UIViewController {
    
    var tests: [Test] = [Test()]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for (_,test) in tests.enumerated(){
            test.call { (result) in
                switch result {
                case .success(let movies):
                    print(movies)
                case .failure(let error):
                    print(error)
                    
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

struct User{
    
}

struct MYValidator: VMResultValidatorApi{
    func validateResponse(_ result: VMWSResponse) -> Result<VMWSResponse, VMWebServiceError> {
        let resultJson = result.resultData as? String
        if resultJson == nil{
            return Result.failure(.requestGenerationFailed)
        }
        return Result.success(result)
    }
    
}




class Test: VMWebService{
    var webServiceComponent: VMWebServiceComponent = VMWebServiceComponent()
    
    func url() -> String {
        return "https://httpbin.org/get"
    }
    
    enum TestApiError: Error{
        case Unauthorised
    }
    
    func validalidatorClient() -> VMResultValidatorApi? {
        return MYValidator()
    }

    
    var handler : ((Result<User, VMWebServiceError>) -> Void)?
    
    
    func call(_ completionHandler: @escaping (Result<User, VMWebServiceError>) -> Void) {
        handler = completionHandler
        
        apiCall {(result) in
            switch result {
            case .success(let resultString):
                print(resultString)
            case .failure(let error):
                print(error)
                completionHandler(Result.failure(error))
            }
            
        }
        
        DispatchQueue.main.async {
            self.cancel()
        }
    }
}



