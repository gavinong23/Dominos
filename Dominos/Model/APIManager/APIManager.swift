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
        case Pizza = "/5afbd9aec83f6d4cc734966c/3"
    }
    
    func callAPIGetPizzas(onSuccess successCallback: ((_ pizzas: [DominoModel]) -> Void)?,
                          onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        
        let url = Config.Url.API_BASE_URL + EndPoint.Pizza.rawValue
        print(url)
        
        // call API
        self.createRequest(
            url, method: .get, headers: Config.ApiKey.API_KEY, parameters: nil,
            onSuccess: {(responseObject: JSON) -> Void in
                
                //print(responseObject)
                //let x = [DominoModel(JSON: responseObject[["response"]][0])]
                
                var dominoModels = [DominoModel]()
                

                
                let pizzaData:[DominoModel] = responseObject["response"]
                    .arrayValue
                    .map{ DominoModel(JSON: $0) }
                
                    successCallback!(pizzaData)
                
//                for (index,pizza) in responseObject["response"]{
//                    let single = [DominoModel(JSON: responseObject["response"][index])]
//                    print(single)
//                }
                    //print(pizza)
                  // let pizza = [DominoModel(JSON: responseObject["response"])]
                    
                

                   //successCallback!(pizza)
                
                
               
                
//                responseObject.map{ pizza in
//                    DominoModel(JSON: responseObject[["response"]][pizza])
//
//                }
               // successCallback!(x)
                
                
                
                // Create dictionary
                //print(responseObject)
                if let responseDict = responseObject["response"].arrayObject{
                   // print(responseDict)
                    
                    
//                    let pizzaDict = responseDict as! [[String: AnyObject]]
//
//                    //print(pizzaDict)
//
//                    let pizza = self.parsePizza(jsonResponse: pizzaDict)
//
//                   // print(pizza)
//
//                    if let pizza = pizza{
//                         successCallback?(pizza)
//                    }
//
//                    let pizza = self.parsePizza(jsonResponse: responseDict as AnyObject)
                 
                } else {
                    failureCallback?("An error has occured.")
                }
        },
            onFailure: {(errorMessage: String) -> Void in
                print(errorMessage)
                failureCallback?(errorMessage)
        }
        )
        
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
    
//    private func parsePizza(jsonResponse: [[String: AnyObject]]) -> [DominoModel]?{
//
//       // let responseDictionary = jsonResponse as NSDictionary
//        do{
//            let responseDictionary = try JSONSerialization.data(withJSONObject: jsonResponse, options: []) as! NSDictionary
//
//           // print(responseDictionary)
//        }catch let error as NSError{
//
//        }
//       // print(responseDictionary)
//       // print(jsonResponse)
        //return Mapper<DominoModel>().mapArray(JSONObject: jsonResponse)
//    }
}
    
    
    
    
    

