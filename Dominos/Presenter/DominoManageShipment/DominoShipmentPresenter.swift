//
//  DominoShipmentPresenter.swift
//  Dominos
//
//  Created by Gavin Ong on 14/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces
import GoogleMaps


//enum DominoCheckoutEnumRoute{
//    case pizzaManageShipmentDetails
//    
//    func segueID() -> String{
//        switch self{
//        case .pizzaManageShipmentDetails:
//            //            return ""
//            return R.segue.dominoCheckoutViewController.checkoutToShipmentDetails.identifier
//        }
//        
//    }
//    
//}

class DominoShipmentPresenter{
    
     private let userService: UserService
     private let locationService: LocationService
     private let pizzaService: PizzaService
     weak private var dominoShipmentView : DominoShipmentViewType?
    
    var currentAddressID: String?
    
    var userID: String?
    var selectedAddress: String?
    
    init(userService: UserService, locationService: LocationService, pizzaService: PizzaService){
        self.userService = userService
        self.locationService = locationService
        self.pizzaService = pizzaService
    }
    
    func attachView(view: DominoShipmentViewType){
        dominoShipmentView = view
    }
    
    func detachView(){
        dominoShipmentView = nil
        
    }
    
    
//    func setupGoogleMap(mapContainerView:UIView, target: CLLocationCoordinate2D,zoom : Float){
////        self.locationService.setupGoogleMap(mapContainerView: mapContainerView, target: target, zoom: zoom)
//    }
    
    func setupMarker(target:CLLocationCoordinate2D) {
        
        //set marker to the view
        let marker = self.locationService.setupMarker(target: target)
        
        self.dominoShipmentView?.drawMarkerView(marker: marker)
    }
    
    func addressAutoComplete(searchString: String){
        
        
        let debouncedFunction  = Debouncer(delay: Config.Timer.debounceTimer){
            
            print("delayed")
            self.locationService.autoCompleteAddress(searchString: searchString, onSuccess: { (addresses) in
                
                if addresses.count > 0{
                    self.dominoShipmentView?.setAutoCompleteAddress(address: addresses)
                    //                print(addresses)
                    self.dominoShipmentView?.reloadAddressAutoCompletionData()
                }else{
                    self.dominoShipmentView?.hideAutoCompletionTableView()
                }
                
                
                
            }, onFailure: { (errorMessage) in
                print(errorMessage)
            })
        }
        
        if searchString == ""{
            debouncedFunction.call()
            self.dominoShipmentView?.searchAddressStringNull()
        }else{
            
            debouncedFunction.call()
        }
        
       
        
       
    }
    
    func getPlaceDetail(placeID: String){
        self.locationService.getPlaceDetail(placeID: placeID, onSuccess: { (place) in
//            self.locationService.place.coordinate
            let marker = self.locationService.setupMarkerWithTitle(title: place.name,target: place.coordinate)
            
            self.dominoShipmentView?.updateViewWhenAddressResultViewRowTap(marker: marker, place: place)
            
        }, onFailure: { (errorMessage) in
            //
        })
    }
    
    func getParticularUserAddress(userID: String){
        self.pizzaService.callAPIGetParticularUserAllAddress(userID: userID, onSuccess: { (addresses) in
            
            //print(addresses)
            self.userID = userID
            self.dominoShipmentView?.setChooseAddressView(addresses: addresses)
            
        }, onFailure: { (errorMessage) in
            print(errorMessage)
        })
    }
    
    func uploadNewAddressToServer(uploadAddressText: String){
      
        if uploadAddressText != ""{
            
            // upload to database(model  - pizza service)
            print(uploadAddressText)
            
//            print(self.userID!)
            
            if !self.userID!.isEmpty{
                self.pizzaService.callAPIUploadUserAddress(userID: self.userID!, address: uploadAddressText, onSuccess: { (successMessage) in
                    //show successfully uploaded alert box
                    //self.dominoShipmentView?.showAlertBox(title: successMessage, message: "You left 4 address slot(s).")
                    
                    self.getParticularUserAddress(userID: self.userID!)
                    
                    self.dominoShipmentView?.switchToChooseAddressViewAfterAddedNewAddress()
                }, onFailure: { (errorMessage) in
                    //show alert box
                    self.dominoShipmentView?.showAlertBox(title: "Failed to upload address.", message: errorMessage)
                })
            }

        }else{
            //show alert box
            self.dominoShipmentView?.showAlertBox(title: "Failed to add address.", message: "empty address entered.")
        }
        
        
    }
    
    func confirmationUploadAddress(){
        self.dominoShipmentView?.showConfirmationBoxForAddAddress(title: "Are you sure you want to add this address?", message: "You only left 5 address slot(s)")
    }
    
    func deleteParticularAddress(addressID: String, row: Int, indexPath: IndexPath){
        
        if !self.userID!.isEmpty{
            self.pizzaService.callAPIDeleteUserAddress(userID: self.userID!, addressID: addressID, onSuccess: { (successMessage) in
                
                //reload the address again with api call to get all address again
                self.getParticularUserAddress(userID: self.userID!)
                
                self.userService.removeAddressID(deletedAddressID: addressID)
                self.dominoShipmentView?.deleteAddressUpdateView(row: row, indexPath: indexPath)
            }, onFailure: { (errorMessage) in
                
            })
        }
    }
    
    func confirmationChooseAddress(selectedAddress: String){
        
        self.selectedAddress = selectedAddress
        
        self.currentAddressID = self.userService.retrieveAddressID()
        
        self.dominoShipmentView?.showConfirmationBoxForChoosenAddress(title: "Are you sure you selected the correct delivery address?", message: "The pizza will send to the address you selected.")
    }
    
    func routeTo(){
       
        self.userService.updateAddressID(addressID: self.selectedAddress!)
        self.dominoShipmentView?.routeTo(currentAddressID: self.currentAddressID!)
//        self.dominoShipmentView?.routeTo(screen: .pizzaManageShipmentDetails)
    }
    
}
