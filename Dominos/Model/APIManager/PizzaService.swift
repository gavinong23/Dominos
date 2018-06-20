//
//  PizzaService.swift
//  Dominos
//
//  Created by Gavin Ong on 15/5/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation
import SwiftyJSON


class PizzaService{
//    var bfbgf:[String]
    
    func callAPIGetPizzas(onSuccess successCallback: ((_ pizzas: [DominoListingModel]) -> Void)?,
                          onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        
        APIManager.instance.callAPIGetPizzas(
           
            onSuccess: { (pizzas) in
            successCallback?(pizzas)
                print("requested")
        }, onFailure:{ (errorMessage) in
          print(errorMessage)
            failureCallback?(errorMessage)
        })
    }
    
    func callAPIGetPizzaDetail(pizzaID:String, onSuccess successCallback: ((_ pizzas: DominoDetailModel) -> Void)?,
                               onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        
        APIManager.instance.callAPIGetPizzaWithParam(pizzaID: pizzaID,
            onSuccess: {(pizzas) in
            successCallback?(pizzas)
        }, onFailure: {(errorMessage) in
            failureCallback?(errorMessage)
        })
        
    }
    
    func callAPIPostPizzaDetail(pizzaID:String, onSuccess successCallback: ((_ pizzas: DominoDetailModel) -> Void)?,
                               onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        
        APIManager.instance.callAPIPostPizzaWithParam(
            pizzaID: pizzaID,
            onSuccess: { (pizzas) in
                
            successCallback?(pizzas)
                
        }, onFailure: {(errorMessage) in
            failureCallback?(errorMessage)
        })
        
    }
    
    func callAPIGetParticularUserAllAddress(userID:String,onSuccess successCallback: ((_ addresses: [UserAddressModel]) -> Void)?,
                                            onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        
        
        APIManager.instance.callAPIGetParticularUserAllAddress(userID: userID, onSuccess: { (addresses) in
            
            successCallback?(addresses)
            
            print(addresses)
            
        }, onFailure: { (errorMessage) in
            failureCallback?(errorMessage)
        })
    }
    
    func callAPIUploadUserAddress(userID: String, address: String, onSuccess successCallback: ((_ successMessage: String) -> Void)?,
                                  onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        
        
        APIManager.instance.callAPIUploadAddress(userID: userID, address: address, onSuccess: { (successMessage) in
            successCallback?(successMessage)
        }, onFailure: { (errorMessage) in
            failureCallback?(errorMessage)
        })
        
    }
    
    func callAPIDeleteUserAddress(userID:String, addressID: String, onSuccess successCallback: ((_ successMessage: String) -> Void)?,
                                  onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        
        APIManager.instance.callAPIDeleteParticularAddress(userID: userID, addressID: addressID, onSuccess: { (successMessage) in
            successCallback?(successMessage)
        }, onFailure: {(errorMessage) in
            failureCallback?(errorMessage)
        })
    }
}
