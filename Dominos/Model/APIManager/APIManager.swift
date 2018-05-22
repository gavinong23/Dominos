//
//  APIManager.swift
//  Dominos
//
//  Created by Gavin Ong on 15/5/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

class APIManager{
    
    static let instance = APIManager()
    
//    enum RequestMethod{
//        case get
//        case post
//    }
    
    enum EndPoint: String{
        case Pizza = "/getAllPizza.php"
    }
    
    func callAPIGetPizzas(onSuccess successCallback: ((_ pizzas: [DominoModel]) -> Void)?,
                          onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        
        let url = Config.Url.API_BASE_URL + EndPoint.Pizza.rawValue
        print(url)
        
        // call API
        self.createRequest(
            url, method: .get, headers: nil, parameters: nil,
            onSuccess: {(responseObject: JSON) -> Void in
                
                let pizzaData:[DominoModel] = responseObject["response"]
                    .arrayValue
                    .map{ DominoModel(JSON: $0) }
                
                successCallback!(pizzaData)
      
        },
            onFailure: {(errorMessage: String) -> Void in
                print(errorMessage)
                failureCallback?(errorMessage)
        }
        )
    }
    
    func callAPIGetPizzasWithParam(){
        
    }
    
    func createRequest(_ url: String, method: HTTPMethod, headers: [String:String]?, parameters: AnyObject?, onSuccess successCallback:((JSON)-> Void)?, onFailure failureCallback: ((String)-> Void)?){
        
        Alamofire.request(url,method: method,headers:headers).validate().responseJSON{
            response in
            switch response.result{
                case .success(let value):
                    let json = JSON(value)
                  
                    //print(json)
                    successCallback?(json)
            case .failure(let error):
                if let callback = failureCallback{
                    callback(error.localizedDescription)
                }
            }
        }
        
    }
    
}
    
    
    
    
    

