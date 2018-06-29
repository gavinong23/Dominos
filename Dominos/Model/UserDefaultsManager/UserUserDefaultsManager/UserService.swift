//
//  UserService.swift
//  Dominos
//
//  Created by Gavin Ong on 21/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation



class UserService{
    
    
    var userDefaultsManager = UserDefaultsManager()
    
    func setUserID(){
        UserUserDefaultsManager.sharedManager.setUser()
    }
    
    func setAddressID(){
        UserUserDefaultsManager.sharedManager.setAddress()
    }
    
    func updateAddressID(addressID: String){
        UserUserDefaultsManager.sharedManager.saveAddressID(addressID: addressID)
    }
    
    func updateUserID(userID:String){
        UserUserDefaultsManager.sharedManager.saveUserID(userID: userID)
    }
    
    func retrieveAddressID() -> String{
        return UserUserDefaultsManager.sharedManager.retrieveAddressID()
    }
    
    
    func retrieveUserID() -> String{
        return UserUserDefaultsManager.sharedManager.retrieveUserID()
    }
    
    
    //The address being deleted
    func removeAddressID(deletedAddressID : String){
        UserUserDefaultsManager.sharedManager.removeAddressID(deletedAddressID : deletedAddressID)
    }
    
    
    //Log out
    func removeUserID(){
        UserUserDefaultsManager.sharedManager.removeUserID()
    }
    


}
