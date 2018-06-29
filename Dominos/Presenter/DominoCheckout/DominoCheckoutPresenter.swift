//
//  DominoCheckOutPresenter.swift
//  Dominos
//
//  Created by Gavin Ong on 11/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import GooglePlaces
import SwiftyJSON


enum EnumPaymentType {
    case cc
    case cod

    func getCreditCardID() -> String{
        return "1"
    }
    
    func getCashOnDeliveryID() -> String{
        return "3"
    }
}

struct ShipmentDetailsViewData{
    var address: String?
    var userName: String?
    var email: String?
    var contactNumber: String?
}

enum DominoCheckoutEnumRoute{
    case pizzaManageShipmentDetails
    
    func segueID() -> String{
        switch self{
        case .pizzaManageShipmentDetails:
//            return ""
            return R.segue.dominoCheckoutViewController.checkoutToShipmentDetails.identifier
        }
    }
    
}

class DominoCheckoutPresenter{
    
    weak private var dominoCheckoutView : DominoCheckoutViewType?
    
    var choosenEnumPaymentType: EnumPaymentType?
    private let pizzaService: PizzaService
    private let cartService: CartService
    private let userService: UserService
    
     var pizzaCartModels: [PizzaDetailViewData]?
    
    var currentAddressID:String?
    
    init( pizzaService:PizzaService,userService:UserService,cartService: CartService){
        self.pizzaService = pizzaService
        self.cartService = cartService
        self.userService = userService
    }
    
    func attachView(view: DominoCheckoutViewType){
        dominoCheckoutView = view
    }
    
    func detachView(){
        dominoCheckoutView = nil
        
    }
    
    func showPaymentView(paymentType: EnumPaymentType){
        switch paymentType{
        case .cc:
            self.dominoCheckoutView?.showPaymentView(paymentType: .cc)
            //self.dominoCheckoutView?.disableCreditCardButton()
            self.choosenEnumPaymentType = .cc
        case .cod:
            self.dominoCheckoutView?.showPaymentView(paymentType: .cod)
            //self.dominoCheckoutView?.disableCodButton()
            self.choosenEnumPaymentType = .cod
            
            
        }
    }
    
    
    func placeOrder(){
        
        let userID = self.userService.retrieveUserID()
        let addressID = self.userService.retrieveAddressID()
        
        if userID != "" && addressID != ""{
        
            if self.choosenEnumPaymentType == EnumPaymentType.cc{
                
                
                if(dominoCheckoutView?.checkIsNullCreditCard())!{
                    
                    // error message alert box
                    self.dominoCheckoutView?.showAlertBox(title: "Invalid Credit Card.", message: "Please enter valid credit card to proceed.")
                   
                }else{
                    
                    self.cartService.retrieveFromCart(onSuccess: { (cartPizza) in
                        self.pizzaCartModels = cartPizza
                    }, onFailure: { (String)-> Void in
                        
                    })
                    
                    if let pizzaCartModels = self.pizzaCartModels{
                        
                        print("Order user ID: \(userID)\n")
                        print("Order address ID: \(addressID)")
                        self.pizzaService.callAPIPlaceOrder(paymentTypeID:
                         EnumPaymentType.cc.getCreditCardID(), userID: userID, addressID: addressID, pizzaCartItems: pizzaCartModels, onSuccess: { successMessage in
                            
                        
                            self.dominoCheckoutView?.showSuccessAlertBox(title: "Order Successfully.", message: "Pizza will reach you, after 40mins.")
                           // print("Order Place successfully.")
                            
                            print(successMessage)
                            
                        }, onFailure: { errorMessage in
                            print(errorMessage)
                        })
                    }
                }
            }else if self.choosenEnumPaymentType == EnumPaymentType.cod{
            
                self.cartService.retrieveFromCart(onSuccess: { (cartPizza) in
                    self.pizzaCartModels = cartPizza
                    
                    if let pizzaCartModels = self.pizzaCartModels{
                        print("Order user ID: \(userID)\n")
                        print("Order address ID: \(addressID)")
                        
                        self.pizzaService.callAPIPlaceOrder(paymentTypeID: EnumPaymentType.cod.getCashOnDeliveryID(), userID: userID, addressID: addressID, pizzaCartItems: pizzaCartModels, onSuccess: { successMessage in
                            
                            self.dominoCheckoutView?.showSuccessAlertBox(title: "Order Successfully.", message: "Pizza will reach you, after 40mins and pay your money to the deliver. Thank you.")
                            
                            print("Place order Success Message: \(successMessage)")
                        }, onFailure: { errorMessage in
                            print("Place order Error Message:\(errorMessage)")
                        })
                        
                    }
                
                    
                }, onFailure: { (String)-> Void in
                    
                })
                
    
            }else{
                self.dominoCheckoutView?.showAlertBox(title: "Error Message", message: "Invalid errors.")
            }
            
        }
    }
    
    func setupPaymentMethod(paymentType: EnumPaymentType){
        self.choosenEnumPaymentType = paymentType
        
    }
    
    func routeTo(){
        self.dominoCheckoutView?.routeTo(screen: .pizzaManageShipmentDetails)
    }
    
    func resetAllView(){
        self.dominoCheckoutView?.resetAllView()
        
    }
    
    func removeAllCartItem(){
        self.cartService.removeAllCartItem()
    }
    
    
    func setShipmentDetails(currentAddressID:String){
        let addressID = self.userService.retrieveAddressID()
        
        self.currentAddressID = currentAddressID
       // print(selectedAddressID)
       // print("new Address: \(addressID)")
        //print("current Address: \(self.currentAddressID)")
        
        if addressID.isEmpty{
            self.dominoCheckoutView?.clearShipmentDetails()
        }else{
            if addressID != self.currentAddressID!{
                print("retrieve shipment details called.")
                self.pizzaService.callAPIGetParticularUserShipmentDetails(addressID: addressID, onSuccess: { (shipmentDetails) in
                    let mappedShipmentDetails = ShipmentDetailsViewData(address: shipmentDetails.address, userName: shipmentDetails.userName, email: shipmentDetails.email, contactNumber: shipmentDetails.contactNumber)
                    
                    self.dominoCheckoutView?.setShipmentDetails(shipmentDetails: mappedShipmentDetails)
                }, onFailure: { (errorMessage) in
                    // print("error")
                })
                
            }
        }
    }
    

    
    func setCurrentAddressID(){
        self.currentAddressID = self.userService.retrieveAddressID()
    }
    
    
    
    
}
