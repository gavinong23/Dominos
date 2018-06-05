//
//  DominoCartViewType.swift
//  Dominos
//
//  Created by Gavin Ong on 1/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation



protocol DominoCartViewType : NSObjectProtocol{
    
    func setCart(dominoModels: [PizzaDetailViewData],grandTotal: Float)
    func updateGrandTotal(dominoModels: [PizzaDetailViewData],grandTotal: Float)
    
    
    
}
