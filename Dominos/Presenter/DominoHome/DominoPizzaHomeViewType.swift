//
//  DominoHomeViewType.swift
//  Dominos
//
//  Created by OngBoonFong on 30/04/2018.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation


protocol DominoPizzaHomeViewType: NSObjectProtocol{
    
    func setPizzas(pizzas:[PizzasViewData])
    func setEmptyPizza()
    func startLoading()
    func stopLoading()
    func routeTo(screen: EnumDominoHomeRoute)
}
