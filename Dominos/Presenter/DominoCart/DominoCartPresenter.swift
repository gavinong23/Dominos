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
    private let cartService: CartService
    private let pizzaService : PizzaService
    var pizzaCartModels: [PizzaDetailViewData]?
    var temporaryCartModels: [PizzaDetailViewData]?
    
    init(cartService: CartService, pizzaService: PizzaService) {
        self.pizzaService = pizzaService
        self.cartService = cartService
    }
    
    func attachView(view: DominoCartViewType){
        dominoCartView = view
    }
    
    func detachView(){
        dominoCartView = nil
        
    }
    
    func setCart(items: [PizzaDetailViewData]){
        
        
        
        cartService.retrieveFromCart(onSuccess: { pizza in
            self.pizzaCartModels = pizza
            
        }, onFailure: {(String)-> Void in
            print("error")
         })
        
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
        

        if let pizzaCartModels = self.pizzaCartModels{
           
            if (self.pizzaCartModels?.count)! > 0{
                //pizzaCartModels.filter{$0.pizzaID == item.pizzaID}.
        
            }
            
            self.dominoCartView?.updateGrandTotal(dominoModels: self.pizzaCartModels!,grandTotal: totalPrice ?? 0.0)
        }
    }
    
}
