//
//  DominoPizzaDetailViewType.swift
//  Dominos
//
//  Created by Gavin Ong on 22/5/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation



protocol DominoPizzaDetailViewType: NSObjectProtocol{
    
    
    func setPizzaDetail(pizza: PizzaDetailViewData)
    func getPizzaID() -> String
    func startLoading()
    func stopLoading()
    func setEmptyPizzaDetail()
    
}
