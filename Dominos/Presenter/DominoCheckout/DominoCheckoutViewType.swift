//
//  DominoCheckOutViewType.swift
//  Dominos
//
//  Created by Gavin Ong on 11/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation



protocol DominoCheckoutViewType : NSObjectProtocol{
    
    
    func showPaymentView(paymentType: EnumPaymentType)
    func disableCreditCardButton()
    func disableCodButton()
    func checkIsNullCreditCard() -> Bool
    func showAlertBox(title:String,message:String)
    func showSuccessAlertBox(title: String, message: String)
    func resetAllView()
    func routeTo(screen:DominoCheckoutEnumRoute)
    func setShipmentDetails(shipmentDetails: ShipmentDetailsViewData)
    func clearShipmentDetails()
    func showPayPalView(payment: PayPalPayment)
}
