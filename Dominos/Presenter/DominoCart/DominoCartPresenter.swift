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
    
    func setCart(){
        
        self.pizzaCartModels?.removeAll()
        
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
    
    func removeParticularCartItem(pizzaID: Int){
        
        if let pizzaCartModels = pizzaCartModels{
            
            self.temporaryCartModels = pizzaCartModels
            
            if (temporaryCartModels?.count)! >= 0 {
                if (temporaryCartModels?.filter{$0.pizzaID == String(pizzaID)}.count)! > 0{
                    
                    for (index, pizza) in (temporaryCartModels?.enumerated())!{
                        
                        if( pizza.pizzaID == String(pizzaID)){
                            temporaryCartModels?.remove(at: index)
                            self.dominoCartView?.removeParticularCartItem(dominoModels: temporaryCartModels!)
                            //Update the user defaults
                            cartService.updateCartItem(pizzas: temporaryCartModels!)
                            self.setCart()
                            
                        }
                    }
                }
        
            }else{
                
            }
            
        }
 
    }
    
    func grandTotalWithUpdateQuantity(item: PizzaDetailViewData){
        var totalPrice: Float?
        var editedItemPrice: Float?
        
        if let pizzaCartModels = self.pizzaCartModels{
            
       
            self.temporaryCartModels = pizzaCartModels
            
            if (pizzaCartModels.count) > 0{
                
                for (index, pizza) in (temporaryCartModels?.enumerated())!{
                    
                    if( pizza.pizzaID == item.pizzaID){
                        temporaryCartModels![index] = item
                        
                    }
                }
                
                //print(self.temporaryCartModels)
                
              
                
                if let temporaryCartModels = self.temporaryCartModels{
                    
                    
                    //store to userdefaults
                    cartService.updateCartItem(pizzas: temporaryCartModels)
                    
                    //Update the cart(retrieve it from user default again)
                    self.setCart()
                    
                   totalPrice = temporaryCartModels.map{
                        $0.pizzaPrice! * Float($0.pizzaQuantity!)
                    }.reduce(0, {$0 + $1})
                }
            }
            
            self.dominoCartView?.updateGrandTotal(dominoModels: self.temporaryCartModels!,grandTotal: totalPrice ?? 0.0)
        }
    }
    
    func removeAllCartItem(){
        cartService.removeAllCartItem()
        self.dominoCartView?.removeAllCartItem()
        self.setCart()
    }
    
}
