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
        case getListingPizza = "/getAllPizza.php"
        case getDetailPizza = "/pizzaDetail.php"
    }
    
    func callAPIGetPizzas(onSuccess successCallback: ((_ pizzas: [DominoListingModel]) -> Void)?,
                          onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        
        let url = Config.Url.API_BASE_URL + EndPoint.getListingPizza.rawValue
        
        //convert pizza ID to int
 
        // call API
        self.createGetRequest(
            url, method: .get, headers: nil, parameters: nil,
            onSuccess: {(responseObject: JSON) -> Void in
                
                let pizzaData:[DominoListingModel] = responseObject["response"]
                    .arrayValue
                    .map{ DominoListingModel(JSON: $0) }
                
                successCallback!(pizzaData)
      
        },
            onFailure: {(errorMessage: String) -> Void in
                print(errorMessage)
                failureCallback?(errorMessage)
        }
        )
    }
    
    func callAPIGetPizzaWithParam(pizzaID: String, onSuccess successCallback: ((_ pizza: DominoDetailModel) -> Void)?,
                                  onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        
        let url = Config.Url.API_BASE_URL + EndPoint.getDetailPizza.rawValue + "?&pizzaID=\(pizzaID)"

        //let headers = ["Content-Type":"application/x-www-form-urlencoded"]
        
        self.createGetRequest(url, method: .get, headers: nil, parameters: nil, onSuccess: {(responseObject: JSON)-> Void in
            
            print(responseObject["response"])
            let pizzaData =  DominoDetailModel(JSON: responseObject["response"])
            
            successCallback?(pizzaData)
            
        }, onFailure: {(errorMessage: String)-> Void in
            print("\(errorMessage)")
            failureCallback?(errorMessage)
        })
    }
    
    
    func callAPIPostPizzaWithParam(pizzaID: String, onSuccess successCallback: ((_ pizza: DominoDetailModel) -> Void)?,
                                  onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        
        //let url = Config.Url.API_BASE_URL + EndPoint.getDetailPizza.rawValue + "?&pizzaID=\(pizzaID)"
        let url = Config.Url.API_BASE_URL + EndPoint.getDetailPizza.rawValue
        
        let parameters = ["pizzaID":pizzaID]
        
        print(parameters)
        
        let headers = ["Content-Type":"application/x-www-form-urlencoded"]
        
        self.createPostRequest(url, method: .post, headers: headers, parameters: parameters, encoding: URLEncoding.httpBody, onSuccess: {(responseObject: JSON)-> Void in
            //print(responseObject["response"])
            let pizzaData =  DominoDetailModel(JSON: responseObject["response"])
            
            successCallback?(pizzaData)
    
        }, onFailure: {(errorMessage: String)-> Void in
            //print("\(errorMessage)")
            failureCallback?(errorMessage)
        })
        
//        {}, [], '', :
//
//        http%25%30%30www.google.com
    }
    
    
    
    
    
    
    func createPostRequest(_ url: String, method: HTTPMethod, headers: [String:String]?, parameters: [String:String]?, encoding: URLEncoding,onSuccess successCallback:((JSON)-> Void)?, onFailure failureCallback: ((String)-> Void)?){
        
        Alamofire.request(url,method: method,parameters:parameters,encoding:encoding,headers:headers).validate().responseJSON{
            response in
            print(response.request?.url)
            print(response.request?.httpBody?.description)
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
    
    func createGetRequest(_ url: String, method: HTTPMethod, headers: [String:String]?, parameters: AnyObject?, onSuccess successCallback:((JSON)-> Void)?, onFailure failureCallback: ((String)-> Void)?){
        
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
    
    
    
    
    

