//
//  cartService.swift
//  Dominos
//
//  Created by Gavin Ong on 6/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation


class CartService{
    
    
//    func callAPIGetPizzas(onSuccess successCallback: ((_ pizzas: [DominoListingModel]) -> Void)?,
//                          onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
//
//        APIManager.instance.callAPIGetPizzas(
//
//            onSuccess: { (pizzas) in
//                successCallback?(pizzas)
//                print("requested")
//        }, onFailure:{ (errorMessage) in
//            print(errorMessage)
//            failureCallback?(errorMessage)
//        })
//    }
    
    func setCart(){
        UserDefaultsManager.sharedManager.setCart()
    }
    
    func addToCart(model: PizzaDetailViewData){
        UserDefaultsManager.sharedManager.addPizzaToCart(object: model)
    }
    
    func retrieveFromCart(onSuccess successCallback: ((_ pizzas: [PizzaDetailViewData]) -> Void)?,
                          onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        UserDefaultsManager.sharedManager.retrieveCartItems(onSuccess: { (pizzas) in
            successCallback?(pizzas)
        }, onFailure: {(String)-> Void in
            failureCallback?("Error")
        })
    }
    
    
    
}
