//
//  userUserDefaultsManager.swift
//  Dominos
//
//  Created by Gavin Ong on 21/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation


class UserUserDefaultsManager{
    
    var userDefaultsManager = UserDefaultsManager()
    
    var userID = String()
    var addressID = String()
    
    class var sharedManager: UserUserDefaultsManager{
        struct Static {
            static let instance = UserUserDefaultsManager()
        }
        return Static.instance
    }
    
    func saveAddressID(addressID: String){
       // userDefaultsManager.removeFromUserDefaults(key: Config.preferenceKey.addressID)
        self.addressID = addressID
        userDefaultsManager.saveToUserDefaults(data: addressID, key: Config.preferenceKey.addressID)
    }
    
    func saveUserID(userID: String){
        //userDefaultsManager.removeFromUserDefaults(key: Config.preferenceKey.userID)
        userDefaultsManager.saveToUserDefaults(data: userID, key: Config.preferenceKey.userID)
    }
    
    func setUser(){
        if !(self.userIsEmpty()){
            self.userID = retrieveUserID()
        }else{
            let userID = String()
            self.saveUserID(userID: userID)
            print("User Key Created")
        }
    }

    func setAddress(){
        if !(self.addressIsEmpty()){
           self.addressID = retrieveAddressID()
//            print(self.addressID)
        }else{
            let addressID = String()
            self.saveAddressID(addressID: addressID)
            print("Address Key Created")
        }
    }
    
    func retrieveAddressID() -> String{
        let addressID = userDefaultsManager.retriveDataFromUserDefaults(key: Config.preferenceKey.addressID)
        print(addressID)
        return addressID
    }
    
    
    func retrieveUserID() -> String{
        let userID = userDefaultsManager.retriveDataFromUserDefaults(key: Config.preferenceKey.userID)
        return userID
    }
    
    func removeAddressID(deletedAddressID : String){
        
        if self.addressID == deletedAddressID{
            self.addressID.removeAll()
            userDefaultsManager.removeFromUserDefaults(key: Config.preferenceKey.addressID)
            userDefaultsManager.sync()
        }
    }
    
    func removeUserID(){
        self.userID.removeAll()
        userDefaultsManager.removeFromUserDefaults(key: Config.preferenceKey.userID)
    }
    
    
    func addressIsEmpty() -> Bool{
        if  userDefaultsManager.userDefaultIsEmpty(key: Config.preferenceKey.addressID){
            return true
        }else{
            return false
        }
    }
    
    func userIsEmpty() -> Bool{
        if  userDefaultsManager.userDefaultIsEmpty(key: Config.preferenceKey.userID){
            return true
        }else{
            return false
        }
    }
}
    
    

