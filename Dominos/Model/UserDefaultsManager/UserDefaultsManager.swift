//
//  UserDefaultsManager.swift
//  Dominos
//
//  Created by Gavin Ong on 21/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation



class UserDefaultsManager{
    
    let userDefaults = UserDefaults.standard
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    
    func saveToUserDefaults(data: String, key:String){
        if userDefaults.object(forKey: key) == nil{
            userDefaults.set(data, forKey: key)
            self.sync()
        }else{
//            self.removeFromUserDefaults(key: key)
            userDefaults.set(data, forKey: key)
        }
    }
    
    
    
    func saveToUserDefaults(data: Data, key: String){
        
        if userDefaults.object(forKey: key) == nil{
            
            //let encodedData : Data = NSKeyedArchiver.archivedData(withRootObject: object)
            userDefaults.set(data, forKey: key)
            self.sync()
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
    
    
    func encode<T : Encodable>(object: T) -> Data{
        var data: Data?
        if let encoded = try? encoder.encode(object){
            data = encoded
        }
        return data!
    }
    
    
    func sync(){
         self.userDefaults.synchronize()
    }
  
    
    func retriveDataFromUserDefaults(key:String) -> String{
        
        var data: String?
        
        if !(self.userDefaultIsEmpty(key: key)){
            data = self.userDefaults.string(forKey: key)
            
        }else{
            data = ""
            //self.sync()
        }
        
        return data!
    }
    

    
    
}
