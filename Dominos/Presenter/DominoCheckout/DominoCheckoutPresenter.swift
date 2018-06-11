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

class DominoCheckoutPresenter{
    
    weak private var dominoCheckoutView : DominoCheckoutViewType?
    
    
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
        case .cod:
            self.dominoCheckoutView?.showPaymentView(paymentType: .cod)
        }
    }
    
    
    
    
    
    
    
}
