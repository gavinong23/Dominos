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
    
    enum EndPoint: String{
        case getListingPizza = "/getAllPizza.php"
        case getDetailPizza = "/pizzaDetail.php"
        case getParticularUserAllAddress = "/getParticularUserAllAddress.php"
        case addAddress = "/addAddress.php"
        case deleteParticularAddress = "/deleteParticularAddress.php"

    }
    
    func callAPIGetPizzas(onSuccess successCallback: ((_ pizzas: [DominoListingModel]) -> Void)?,
                          onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        
        let url = Config.Url.API_BASE_URL + EndPoint.getListingPizza.rawValue
        
        // call API
        self.createGetRequest(
            url, headers: nil, parameters: nil,
            onSuccess: {(responseObject: JSON) -> Void in
                
                let pizzaData:[DominoListingModel] = responseObject["response"]
                    .arrayValue
                    .map{ DominoListingModel(JSON: $0) }
                
          
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // change 2 to desired number of seconds
                    successCallback!(pizzaData)
                }
                
        },
            onFailure: {(errorMessage: String) -> Void in
                print(errorMessage)
                failureCallback?(errorMessage)
        }
        )
    }
    
    func callAPIGetParticularUserAllAddress(userID: String,onSuccess successCallback: ((_ pizzas: [UserAddressModel]) -> Void)?,
                                            onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        
        let url = self.createUrlStringWithBaseUrl(EndPoint: EndPoint.getParticularUserAllAddress.rawValue)
        
        
        print(url)
        
        let parameters = ["userID": userID]
        
        self.createPostRequest(url, parameters: parameters, encoding: URLEncoding.httpBody, onSuccess: { (responseObject: JSON) -> Void in
            let addressData:[UserAddressModel] = responseObject["response"].arrayValue.map{
                UserAddressModel(JSON: $0)
            }
            
            print(addressData)
            
            successCallback!(addressData)
            
        }, onFailure: { (errorMessage: String)-> Void in
            failureCallback?(errorMessage)
        })
    }
    
    
    func callAPIUploadAddress(userID:String, address:String,onSuccess successCallback: ((_ responseObject:String) -> Void)?,
                              onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        
        let url = self.createUrlStringWithBaseUrl(EndPoint: EndPoint.addAddress.rawValue)
        
        let parameters = ["userID":userID, "address":address]
        
        self.createPostRequest(url, parameters:parameters, encoding: URLEncoding.httpBody, onSuccess: { (responseObject: JSON) -> Void in
            successCallback!(responseObject["response"].stringValue)
        }, onFailure: { (errorMessage: String)-> Void in
            failureCallback!(errorMessage)
        })
        
    }
    
    func callAPIDeleteParticularAddress(userID: String, addressID: String,onSuccess successCallback: ((_ responseObject:String) -> Void)?,
        onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        
        let url = self.createUrlStringWithBaseUrl(EndPoint: EndPoint.deleteParticularAddress.rawValue)
        
        let parameters = ["userID": userID, "addressID": addressID]
        
        self.createPostRequest(url, parameters: parameters, encoding: URLEncoding.httpBody, onSuccess: { (responseObject: JSON) -> Void in
            successCallback!(responseObject["response"].stringValue)
        }, onFailure: { (errorMessage: String) -> Void in
            failureCallback!(errorMessage)
        })
        
    }
    
    
    func callAPIGetPizzaWithParam(pizzaID: String, onSuccess successCallback: ((_ pizza: DominoDetailModel) -> Void)?,
                                  onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        
        let url = Config.Url.API_BASE_URL + EndPoint.getDetailPizza.rawValue + "?&pizzaID=\(pizzaID)"
        
        self.createGetRequest(url, headers: nil, parameters: nil, onSuccess: {(responseObject: JSON)-> Void in
        
            let pizzaData =  DominoDetailModel(JSON: responseObject["response"])
            
            successCallback?(pizzaData)
            
        }, onFailure: {(errorMessage: String)-> Void in
            print("\(errorMessage)")
            failureCallback?(errorMessage)
        })
    }
    
    func callAPIPostPizzaWithParam(pizzaID: String, onSuccess successCallback: ((_ pizza: DominoDetailModel) -> Void)?,
                                  onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        
        let url = Config.Url.API_BASE_URL + EndPoint.getDetailPizza.rawValue
        
        let parameters = ["pizzaID":pizzaID]
    
        self.createPostRequest(url, parameters: parameters, encoding: URLEncoding.httpBody, onSuccess: {(responseObject: JSON)-> Void in

            let pizzaData =  DominoDetailModel(JSON: responseObject["response"])
            
//            print(responseObject)
            
            successCallback?(pizzaData)
    
        }, onFailure: {(errorMessage: String)-> Void in
            
            failureCallback?(errorMessage)
            
        })
        

    }
    

    func createUrlStringWithBaseUrl(EndPoint: String) -> String{
        return Config.Url.API_BASE_URL + EndPoint
    }
    
    func createPostRequest(_ url: String, parameters: [String:String]?, encoding: URLEncoding,onSuccess successCallback:((JSON)-> Void)?, onFailure failureCallback: ((String)-> Void)?){
        
        let headers = ["Content-Type":"application/x-www-form-urlencoded"]
        
        Alamofire.request(url,method: .post,parameters:parameters,encoding:encoding,headers:headers).validate().responseJSON{
            response in
            
        

            switch response.result{
            case .success(let value):
                let json = JSON(value)
                
                successCallback?(json)
            case .failure(let error):
                if let callback = failureCallback{
                    callback(error.localizedDescription)
                }
            }
        }
    }
    
    func createGetRequest(_ url: String, headers: [String:String]?, parameters: AnyObject?, onSuccess successCallback:((JSON)-> Void)?, onFailure failureCallback: ((String)-> Void)?){
        
        Alamofire.request(url,method: .get,headers:headers).validate().responseJSON{
            response in
            switch response.result{
                case .success(let value):
                    
                    let json = JSON(value)
                    successCallback?(json)
                
                
            case .failure(let error):
                if let callback = failureCallback{
                    callback(error.localizedDescription)
                }
            }
        }
    }
    
    
    
    
    
}
    
    
    
    
    

