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
        print(self.pizzaCartModels)
    }
    
    
    func calculateGrandTotal(item: PizzaDetailViewData){
        var totalPrice: Float?
        
        
        if let pizzaCartModels = self.pizzaCartModels{
           
            if (self.pizzaCartModels?.count)! > 0{
                print(pizzaCartModels.filter{$0.pizzaID == item.pizzaID})
                totalPrice = Float(pizzaCartModels.filter{$0.pizzaID == item.pizzaID}.map{ $0.pizzaPrice! * Float($0.pizzaQuantity!) }.description)
                
                print(totalPrice)
            }
            
            self.dominoCartView?.updateGrandTotal(grandTotal: totalPrice ?? 0.00)
            
        }
        
        
        //            dominoModel.quantity = newQuantity
        //            self.dominoCartPresenter.updateCart(item:dominoModel)
        //
        //
        //            //presenter
        //            let pizzaList:[String]
        //            func updateCart(item:DominoModel) {
        //                if pizzaList.count > 0 {
        //                    pizzaList.filter{ $0.id == item.id }.map{ $0 = item }
        //
        //                    if let i = pizzaList.index(where: { $0.id == item.id }) {
        //                        pizzaList[i] = item
        //                    }
        //                }
        //            }
        
    }
    
    
    
}
