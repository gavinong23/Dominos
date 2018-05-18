//
//  PizzaService.swift
//  Dominos
//
//  Created by Gavin Ong on 15/5/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation


class PizzaService{
    
    
    func callAPIGetPizzas(onSuccess successCallback: ((_ pizzas: [DominoModel]) -> Void)?,
                          onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        
        APIManager.instance.callAPIGetPizzas(
            onSuccess: { (pizzas) in
            successCallback?(pizzas)
        }, onFailure:{ (errorMessage) in
          
            failureCallback?(errorMessage)
        })
    }
}
