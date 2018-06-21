//
//  Global.swift
//  Dominos
//
//  Created by Gavin Ong on 5/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation


class CartUserDefaultsManager{
    
    let userDefaults = UserDefaults.standard
    let decoder = JSONDecoder()
    
    var userDefaultsManager = UserDefaultsManager()
    
    
    var sharedGlobalCart = [PizzaDetailViewData]()
    
    class var sharedManager: CartUserDefaultsManager{
        struct Static {
            static let instance = CartUserDefaultsManager()
        }
        return Static.instance
    }
    
    func updateCartItem(pizzas:[PizzaDetailViewData]){
            
            self.sharedGlobalCart = pizzas
          //  print(self.sharedGlobalCart)
            
           // print(self.sharedGlobalCart.count)
        
            //userDefaults.set(encoded, forKey: key)
            userDefaultsManager.saveToUserDefaults(data:userDefaultsManager.encode(object: self.sharedGlobalCart), key: Config.preferenceKey.cartModels)
        }
    
        func retrieveFromCart(key: String, onSuccess successCallback:((Any)-> Void)?, onFailure failureCallback: ((String)-> Void)?){
   
            if userDefaults.object(forKey: key) != nil{
    
                if let savedItem = userDefaults.object(forKey: key) as? Data{
    
                    if let loadedItems = try? decoder.decode([PizzaDetailViewData].self, from: savedItem){
                        //print(loadedItems)
                            successCallback?(loadedItems)
                    }else{
                        failureCallback?("fail")
                    }
                }
    
            }else{
                failureCallback?("")
            }   
        }
    
    
    // Add To Cart
    func addPizzaToCart(object: PizzaDetailViewData){
       
             self.sharedGlobalCart.append(object)
             print(self.sharedGlobalCart)
            
           print(self.sharedGlobalCart.count)
            
            //userDefaults.set(encoded, forKey: key)
             userDefaultsManager.saveToUserDefaults(data:userDefaultsManager.encode(object: self.sharedGlobalCart), key: Config.preferenceKey.cartModels)
            
       
        
    }
    
    func setCart(){
//        self.removeCart()
        if !(self.cartIsEmpty()){
            self.retrieveCartItems(onSuccess: { pizza in
                //print(pizza)
                self.sharedGlobalCart = pizza
                print(self.sharedGlobalCart.count)
            }, onFailure: {errorMessage in
                print(errorMessage)
            })
        }else{
            let pizzaDetailViewData = [PizzaDetailViewData]()
             userDefaultsManager.saveToUserDefaults(data: userDefaultsManager.encode(object: pizzaDetailViewData), key: Config.preferenceKey.cartModels)
            print("Key Created")
        }
    }
    
    
    //Retreive from Cart
    func retrieveCartItems(onSuccess successCallback: ((_ pizza: [PizzaDetailViewData]) -> Void)?,
                           onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        self.retrieveFromCart(key: Config.preferenceKey.cartModels, onSuccess: { pizza in
            //print(pizza)
        
            successCallback?(pizza as! [PizzaDetailViewData])
        }, onFailure: {(String)-> Void in
            
            failureCallback?("Failed to retrieve cart item.saasas")
            
        })
    }
    
    //Remove from cart
    func removeCart(){
        self.sharedGlobalCart.removeAll()
         userDefaultsManager.removeFromUserDefaults(key: Config.preferenceKey.cartModels)
         userDefaultsManager.sync()
    }
    
    func cartIsEmpty() -> Bool{
        if  userDefaultsManager.userDefaultIsEmpty(key: Config.preferenceKey.cartModels){
            return true
        }else{
            return false
        }
    }
    
}

//    func decode<T : Encodable>(keys: ModelName, key: String) {
//
//        if let savedItem = userDefaults.object(forKey: key) as? Data{
//
//            if let loadedItems = try? decoder.decode(, from: savedItem){
//
//            }
//            if let loadedItems = try? decoder.decode(decodingType, from: savedItem){
//
//            }else{
//                failureCallback?("fail")
//            }
//        }
//    }
