//
//  DominoCheckOutPresenter.swift
//  Dominos
//
//  Created by Gavin Ong on 11/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation


enum EnumPaymentType {
    case cc
    case cod
}

enum DominoCheckoutEnumRoute{
    case pizzaHome
    
    func segueID() -> String{
        switch self{
        case .pizzaHome:
//            return ""
            return R.segue.dominoCheckoutViewController.checkoutToHomeID.identifier
        }
        
    }
    
}

class DominoCheckoutPresenter{
    
    weak private var dominoCheckoutView : DominoCheckoutViewType?
    
    var choosenEnumPaymentType: EnumPaymentType?
    
    
    init() {

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
        if self.choosenEnumPaymentType == EnumPaymentType.cc{
            if(dominoCheckoutView?.checkIsNullCreditCard())!{
                
                // error message alert box
                
                self.dominoCheckoutView?.showAlertBox(title: "Invalid Credit Card.", message: "Please enter valid credit card to proceed.")
               
            }else{
                
                self.dominoCheckoutView?.showSuccessAlertBox(title: "Order Successfully.", message: "Pizza will reach you, after 40mins.")
                print("Order Place successfully.")
                
                // route to home
              // self.dominoCheckoutView?.routeTo(screen: .pizzaHome)
                

            }
        }else if self.choosenEnumPaymentType == EnumPaymentType.cod{
            
          
            print("Order Place successfully.")
        
              self.dominoCheckoutView?.showSuccessAlertBox(title: "Order Successfully.", message: "Pizza will reach you, after 40mins.")
            
            
        }else{
            self.dominoCheckoutView?.showAlertBox(title: "Invalid Credit Card.", message: "Please enter valid credit card to proceed.")
        }
    }
    
    func setupPaymentMethod(paymentType: EnumPaymentType){
        self.choosenEnumPaymentType = paymentType
        
    }
    
    
    func routeTo(){
        self.dominoCheckoutView?.routeTo(screen: .pizzaHome)
        
    }
    
    
    
    
}
