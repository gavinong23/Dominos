//
//  DominoCartPresenter.swift
//  Dominos
//
//  Created by Gavin Ong on 1/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation


class DominoCartPresenter{
    
    weak private var dominoCartView : DominoCartViewType?
    
    var pizzaCartModels: [PizzaDetailViewData]?
    
    func attachView(view: DominoCartViewType){
        dominoCartView = view
    }
    
    func detachView(){
        dominoCartView = nil
        
    }
    
    func setCart(items: [PizzaDetailViewData]){
        self.pizzaCartModels =  items
        
        var totalPrice: Float?
        
        if let pizzaCartModels = self.pizzaCartModels{
            
            if(self.pizzaCartModels?.count)! > 0{
                totalPrice = pizzaCartModels.map{$0.pizzaPrice! * Float($0.pizzaQuantity!)}.first
                
                print(totalPrice)
            }
        }
        self.dominoCartView?.setCart(grandTotal: totalPrice ?? 0.0)

    }
    
    func grandTotalWithUpdateQuantity(item: PizzaDetailViewData){
        var totalPrice: Float?
        
        //let preferences = UserDefaults.standardUserDefaults
        
        preferences.setValue(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
        
        if let pizzaCartModels = self.pizzaCartModels{
           
            if (self.pizzaCartModels?.count)! > 0{
    
                let pizza = pizzaCartModels.filter{$0.pizzaID == item.pizzaID}.first
                
                if let pizza = pizza{
                   totalPrice = pizza.pizzaPrice! * Float(item.pizzaQuantity!)
                }
        
            }
            self.dominoCartView?.updateGrandTotal(grandTotal: totalPrice ?? 0.0)
        }
    }
    
}
