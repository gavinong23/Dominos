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
}
