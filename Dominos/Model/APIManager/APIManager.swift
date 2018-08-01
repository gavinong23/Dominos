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


struct OrderPizzaData : Codable {
    
    var pizzaID: String
    var pizzaQuantity: Double
    
    
    init(pizzaID:String, pizzaQuantity: Double){
        self.pizzaID = pizzaID
        self.pizzaQuantity = pizzaQuantity
    }
    
    enum CodingKeys: String, CodingKey {
        case pizzaID = "pizzaID"
        case pizzaQuantity = "pizzaQuantity"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.pizzaID = try values.decode(String.self, forKey: .pizzaID)
        self.pizzaQuantity = try values.decode(Double.self, forKey: .pizzaQuantity)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(pizzaID, forKey: .pizzaID)
        try container.encode(pizzaQuantity, forKey: .pizzaQuantity)

    }
}

class APIManager{
    
    static let instance = APIManager()
     let encoder = JSONEncoder()
    
    var mappedPizzaOrderDetail =  [OrderPizzaData]()
    
    enum EndPoint: String{
        case getListingPizza = "/getAllPizza.php"
        case getDetailPizza = "/pizzaDetail.php"
        case getParticularUserAllAddress = "/getParticularUserAllAddress.php"
        case addAddress = "/addAddress.php"
        case deleteParticularAddress = "/deleteParticularAddress.php"
        case getParticularUserShipmentDetails = "/getParticularUserShipmentDetails.php"
        case placeOrder = "/placeOrder.php"

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
                    .map{ DominoListingModel(JSON: $0)
                        
                }
                
          
                
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
        
        
       // print(url)
        
        let parameters = ["userID": userID]
        
        self.createPostRequest(url, parameters: parameters, encoding: URLEncoding.httpBody, onSuccess: { (responseObject: JSON) -> Void in
            let addressData:[UserAddressModel] = responseObject["response"].arrayValue.map{
                UserAddressModel(JSON: $0)
            }
            
          //  print(addressData)
            
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
    
    func callAPIGetParticularUserShipmentDetails(addressID: String, onSuccess successCallback: ((_ responseObject: UserAddressModel) -> Void)?, onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        
        let url = self.createUrlStringWithBaseUrl(EndPoint: EndPoint.getParticularUserShipmentDetails.rawValue)
        
        let parameters = ["addressID": addressID]
        
        
        self.createPostRequest(url, parameters: parameters, encoding: URLEncoding.httpBody, onSuccess: { (responseObject: JSON)-> Void in
            let shipmentData = UserAddressModel(JSON: responseObject["response"])
            
           // print(shipmentData)
            
            successCallback?(shipmentData)
            
        }, onFailure: { (errorMessage: String)-> Void in
            
            failureCallback?(errorMessage)
            
        })
        
    }
    
//    func json(from object:Any) -> String? {
//        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
//            return nil
//        }
//        return String(data: data, encoding: String.Encoding.utf8)
//    }
    
    
    func callAPIPlaceOrder(paymentTypeID:String,userID:String, addressID: String, pizzaCartItems:[PizzaDetailViewData], onSuccess successCallback: ((_ responseObject:String) -> Void)?, onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        
        let url = self.createUrlStringWithBaseUrl(EndPoint: EndPoint.placeOrder.rawValue)
        
       // print(pizzaCartItems)
        
       self.mappedPizzaOrderDetail =  pizzaCartItems.map{
               return OrderPizzaData(pizzaID: $0.pizzaID ?? "", pizzaQuantity: $0.pizzaQuantity ?? 0.0)
        
        }
      
       // let encodedData = try? JSONEncoder().encode(self.mappedPizzaOrderDetail)
        
       // var json: Any?
        
//        if let data = encodedData{
//            json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
//        }
        
      //  if let json = json{
           // print(json)
            
            let parameters = ["paymentTypeID": paymentTypeID,"addressID":addressID,"userID": userID, "cartItems": self.encode(object: self.mappedPizzaOrderDetail)] as [String : Any]
        
            self.createPostRequestJSON(url, parameters: parameters, onSuccess: {(responseObject: String) -> Void in
                
                
                print(responseObject)
                successCallback!(responseObject)
            }, onFailure: { (errorMessage: String)-> Void in
                failureCallback!(errorMessage)
            })
        
        //}
    }
    
    
    //        let parameters = ["userID": userID, "addressID":addressID, "cartItems":pizzaCartItems] as [String : Any]
    
    //print(mappedPizzaOrderDetail)
    
    //let pizzaCartItems = pizzaCartItems.dictionary
    
    //print("Pizza cart items dictionary: \(String(describing: pizzaCartItems))")
    //        let pizzaCartItems = pizzaCartItems.map{
    //            $0.dictionary
    //        }
    
    //        let pizzaID = pizzaCartItems.map{
    //            [$0.pizzaID!.dictionary, $0.pizzaQuantity!.dictionary]
    //        }
    //
    
    
//    func json(from object:Any) -> String? {
//        guard let data = try? JSONSerialization.jsonObject(with: object, options: []) else {
//            return nil
//        }
//        return String(data: data, encoding: String.Encoding.utf8)
//    }
    

    
    func encode<T : Encodable>(object: T) -> String{
        var data: String?
        if let encoded = try? encoder.encode(object){
            data = String(data: encoded, encoding: String.Encoding.utf8)
        }
        return data!
    }
    

    
    func JSONStringify(value: AnyObject,prettyPrinted:Bool = false) -> String{
        
        let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions(rawValue: 0)
        
        
        if JSONSerialization.isValidJSONObject(value) {
            
            do{
                let data = try JSONSerialization.data(withJSONObject: value, options: options)
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string as String
                }
            }catch {
                
                print("error")
                //Access error here
            }
            
        }
        return ""
        
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
    
    func createPostRequestJSON(_ url: String, parameters:[String:Any]?, onSuccess successCallback:((String)-> Void)?, onFailure failureCallback: ((String)-> Void)?){
        
        let headers = ["Content-Type":"application/x-www-form-urlencoded"]
        
        
        
        Alamofire.request(url,method: .post,parameters:parameters,encoding:  URLEncoding.default,headers:headers).validate().responseString{
            response in
            
            switch response.result{
            case .success(let value):
                let jsonString = value
                
                successCallback?(jsonString)
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
    
    
    
    
    

