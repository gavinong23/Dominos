//
//  PizzaService.swift
//  Dominos
//
//  Created by Gavin Ong on 15/5/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation


class PizzaService{
    
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
}
