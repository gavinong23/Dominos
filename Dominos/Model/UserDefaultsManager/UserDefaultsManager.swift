//
//  Global.swift
//  Dominos
//
//  Created by Gavin Ong on 5/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation


class UserDefaultsManager{
    
    let userDefaults = UserDefaults.standard
    //static let instance = UserDefaultsManager()
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    
    
    
    var sharedGlobalCart = [PizzaDetailViewData]()
    
    class var sharedManager: UserDefaultsManager{
        struct Static {
            static let instance = UserDefaultsManager()
        }
        return Static.instance
    }
    
    func saveToUserDefaults(data: Data, key: String){
       
        if userDefaults.object(forKey: key) == nil{
            
            //let encodedData : Data = NSKeyedArchiver.archivedData(withRootObject: object)
            userDefaults.set(data, forKey: key)
            userDefaults.synchronize()
        }else{
            self.removeFromUserDefaults(key: key)
            
            userDefaults.set(data, forKey: key)
           
        }
    }
    
    func userDefaultIsEmpty(key: String) -> Bool{
        if userDefaults.object(forKey: key) == nil{
            return true
        }else{
            return false
        }
    }
    
    func removeFromUserDefaults(key: String){
        if userDefaults.object(forKey: key) != nil{
            userDefaults.removeObject(forKey: key)
        }
    }
    
//    func retrieveFromUserDefaults(decodingType : ModelName, key: String, onSuccess successCallback:((Any)-> Void)?, onFailure failureCallback: ((String)-> Void)?){
//
//        if userDefaults.object(forKey: key) != nil{
//
//            //var result = [String: AnyCodable](minimumCapacity: decodingType.count)
//
//            if let savedItem = userDefaults.object(forKey: key) as? Data{
//
//                if let loadedItems = try?  decodingType.modelType.decode(from:  decoder, data: savedItem){
////                    print(loadedItems)
////                        successCallback?(loadedItems)
//                }else{
//                    failureCallback?("fail")
//                }
//            }
//
//        }else{
//            failureCallback?("")
//        }
//    }
    
    
        func updateCartItem(pizzas:[PizzaDetailViewData]){
            
            self.sharedGlobalCart = pizzas
            print(self.sharedGlobalCart)
            
            print(self.sharedGlobalCart.count)
            
            //userDefaults.set(encoded, forKey: key)
            self.saveToUserDefaults(data:self.encode(object: self.sharedGlobalCart), key: Config.preferenceKey.cartModels)
        }
    
        func retrieveFromCart(key: String, onSuccess successCallback:((Any)-> Void)?, onFailure failureCallback: ((String)-> Void)?){
   
            if userDefaults.object(forKey: key) != nil{
    
                if let savedItem = userDefaults.object(forKey: key) as? Data{
    
                    if let loadedItems = try? decoder.decode([PizzaDetailViewData].self, from: savedItem){
                        print(loadedItems)
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
            self.saveToUserDefaults(data:self.encode(object: self.sharedGlobalCart), key: Config.preferenceKey.cartModels)
            
       
        
    }
    
    func setCart(){
        
//        self.removeCart()
        if !(self.cartIsEmpty()){
            self.retrieveCartItems(onSuccess: { pizza in
                //print(pizza)
                self.sharedGlobalCart = pizza
                print(self.sharedGlobalCart.count)
            }, onFailure: {errorMessage in
                print("gg")
            })
        }else{
            let pizzaDetailViewData = [PizzaDetailViewData]()
            self.saveToUserDefaults(data: self.encode(object: pizzaDetailViewData), key: Config.preferenceKey.cartModels)
            print("Key Created")
        }
    }
    
    func encode<T : Encodable>(object: T) -> Data{
        var data: Data?
        if let encoded = try? encoder.encode(object){
            data = encoded
        }
        return data!
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
    
    
    
    
    //Retreive from Cart
    func retrieveCartItems(onSuccess successCallback: ((_ pizza: [PizzaDetailViewData]) -> Void)?,
                           onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        self.retrieveFromCart(key: Config.preferenceKey.cartModels, onSuccess: { pizza in
            //print(pizza)
        
            successCallback?(pizza as! [PizzaDetailViewData])
        }, onFailure: {(String)-> Void in
            
            failureCallback?("Error")
            
        })
    }
    
    //Remove from cart
    func removeCart(){
        self.removeFromUserDefaults(key: Config.preferenceKey.cartModels)
    }
    
    func cartIsEmpty() -> Bool{
        if self.userDefaultIsEmpty(key: Config.preferenceKey.cartModels){
            return true
        }else{
            return false
        }
    }
    
}
