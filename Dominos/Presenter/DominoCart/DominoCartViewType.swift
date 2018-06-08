//
//  DominoCartViewType.swift
//  Dominos
//
//  Created by Gavin Ong on 1/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation



protocol DominoCartViewType : NSObjectProtocol{
    
    func setCart(dominoModels: [PizzaDetailViewData], subTotal: Float,grandTotal: Float)
    func updateSubTotal(dominoModels: [PizzaDetailViewData],grandTotal: Float)
    func removeParticularCartItem(dominoModels: [PizzaDetailViewData])
    func removeAllCartItem()
    func setDeliveryFee(deliveryFee:Float)
    func showAlertBox(title:String,message:String)
    
    
}
