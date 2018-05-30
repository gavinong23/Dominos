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
    func filterPizza(pizzas:[PizzasViewData])
    func noConnection(errorMessage:String, isConnectedToNetwork: Bool)
    func showPickerView()
    func stopRefresher()
    func startLoading()
    func stopLoading()
    func routeTo(screen: EnumDominoHomeRoute)
    
}
