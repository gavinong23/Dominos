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
        
        let userDefaults = UserDefaults.standard
        
        if let savedCartItems = userDefaults.object(forKey: Config.preferenceKey.cartModels) as? Data {
            let decoder = JSONDecoder()
            
            if let loadedCartItems = try? decoder.decode([PizzaDetailViewData].self, from: savedCartItems) {
                self.pizzaCartModels = loadedCartItems
            }
        }
        
//        //self.pizzaCartModels =  items
//
       // var totalPrice: Float = 0.00
        var totalPrice : Float?

        if let pizzaCartModels = self.pizzaCartModels{

            if(self.pizzaCartModels?.count)! > 0{
                totalPrice = pizzaCartModels.map{$0.pizzaPrice! * Float($0.pizzaQuantity!)}.reduce(0,{$0 + $1})

                print(totalPrice)
            }
        }
        self.dominoCartView?.setCart(dominoModels: self.pizzaCartModels!, grandTotal: totalPrice ?? 0.00)

    }
    
    func grandTotalWithUpdateQuantity(item: PizzaDetailViewData){
        var totalPrice: Float?
        
   
        //let preferences = UserDefaults.standardUserDefaults
        
        
        if let pizzaCartModels = self.pizzaCartModels{
           
            if (self.pizzaCartModels?.count)! > 0{
    
//                let editedQuantityPriceItem = pizzaCartModels.filter{$0.pizzaID == item.pizzaID}.map{$0.pizzaPrice! * Float(item.pizzaQuantity!)}.first
                var pizzaQuantity = pizzaCartModels.filter{$0.pizzaID == item.pizzaID}.first?.pizzaQuantity
                
                pizzaQuantity = item.pizzaQuantity
                
                print(pizzaCartModels)
               // totalPrice = pizzaCartModels.filter{$0.pizzaID != item.pizzaID}.map{$0.pizzaPrice! * Float($0.pizzaQuantity!)}.reduce(0, {$0 + $1}) + editedQuantityPriceItem!
                
                
                
//                pizzaCartModels.filter{$0.pizzaID == item.pizzaID}.forEach{
//                    var quantity = item.pizzaQuantity
//                    $0.pizzaQuantity = quantity
//
//                }
//
//                pizzaCartModels.filter{$0.pizzaID == item.pizzaID}.first?.pizzaQuantity = 1
                
                
//                if let pizza = pizza{
//                    if let pizzaCartModels = self.pizzaCartModels{
//                        if(self.pizzaCartModels?.count)! > 0{
//
//                            totalPrice = pizzaCartModels.map{$0.pizzaPrice! * Float($0.pizzaQuantity!)}.reduce(0,{$0 + $1})
//                        }
//                    }
////                    pizza.pizzaPrice! * Float(item.pizzaQuantity!)
//                }
        
            }
            self.dominoCartView?.updateGrandTotal(dominoModels: self.pizzaCartModels!,grandTotal: totalPrice ?? 0.0)
        }
    }
    
}
