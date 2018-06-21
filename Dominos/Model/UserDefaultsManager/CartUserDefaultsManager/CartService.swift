//
//  cartService.swift
//  Dominos
//
//  Created by Gavin Ong on 6/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation


class CartService{
    
    func setCart(){
        CartUserDefaultsManager.sharedManager.setCart()
    }
    
    func addToCart(model: PizzaDetailViewData,onSuccess successCallback: ((_ successMessage: String) -> Void)?,
                   onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        
        CartUserDefaultsManager.sharedManager.retrieveCartItems(onSuccess: { (pizzas) in
            
            
            if (pizzas.filter{$0.pizzaID == model.pizzaID}.count) == 0 {
                CartUserDefaultsManager.sharedManager.addPizzaToCart(object: model)
                successCallback?("")
            }else{
                failureCallback?("The item already added to cart.")
            }
            
      
        }, onFailure: {(errorMessage) in
            failureCallback?(errorMessage)
        })
        
        
    }
    
    func retrieveFromCart(onSuccess successCallback: ((_ pizzas: [PizzaDetailViewData]) -> Void)?,
                          onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        CartUserDefaultsManager.sharedManager.retrieveCartItems(onSuccess: { (pizzas) in
            successCallback?(pizzas)
        }, onFailure: {errorMessage in
            failureCallback?(errorMessage)
        })
    }
    
    func updateCartItem(pizzas: [PizzaDetailViewData]){
        CartUserDefaultsManager.sharedManager.updateCartItem(pizzas: pizzas)
    }
    
    func removeAllCartItem(){
        CartUserDefaultsManager.sharedManager.removeCart()
        CartUserDefaultsManager.sharedManager.setCart()
    }

}
