//
//  DominoPizzaDetailPresenter.swift
//  Dominos
//
//  Created by Gavin Ong on 22/5/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

struct PizzaDetailViewData {



    
    var pizzaID: String?
    var pizzaName: String?
    var pizzaDesc: String?
    var pizzaToppingImage: [EnumPizzaToppings]?
    var pizzaFullImage: URL?
    var pizzaThumbnail: URL?
    var pizzaPrice: Float?
    var pizzaQuantity: Double?
    


    
    enum CodingKeys: String, CodingKey{
        case pizzaID = "pizzaID"
        case pizzaName = "pizzaName"
        case pizzaDesc = "pizzaDesc"
        case pizzaToppingImage = "pizzaToppingImage"
        case pizzaFullImage = "pizzaFullImage"
        case pizzaThumbnail = "pizzaThumbnail"
        case pizzaPrice = "pizzaPrice"
        case pizzaQuantity = "pizzaQuantity"
    }
    

}



enum EnumDominoDetailRoute{
    case pizzaCart(model:PizzaDetailViewData)
    
    func segueID() -> String{
        switch self{
            case .pizzaCart:
                return R.segue.dominoPizzaHomeDetailViewController.pizzaDetailToPizzaCartID.identifier
        }
    }
}


class DominoPizzaDetailPrenseter{
    private let cartService: CartService
    private let pizzaService : PizzaService
    weak private var dominoPizzaDetailView : DominoPizzaDetailViewType?
    var totalQuantity: Double = 1.0
    var pizzaCartItems = [PizzaDetailViewData]()
   
    
    init(cartService: CartService, pizzaService: PizzaService) {
        self.pizzaService = pizzaService
        self.cartService = cartService
    }

    
    func attachView(view: DominoPizzaDetailViewType){
        dominoPizzaDetailView = view
    }
    
    func dettachView(){
        dominoPizzaDetailView = nil
    }
    
    
    func getPizzaDetail(){
        
        self.dominoPizzaDetailView?.startLoading()
        
        if Reachability.isConnectedToNetwork(){
            
        if let pizzaID = self.dominoPizzaDetailView?.getPizzaID(){
            pizzaService.callAPIPostPizzaDetail(pizzaID: pizzaID, onSuccess: { pizza in
        
                let mappedPizzaDetail = PizzaDetailViewData(pizzaID: pizza.pizzaID ?? "", pizzaName: pizza.pizzaName ?? "", pizzaDesc: pizza.pizzaDesc ?? "", pizzaToppingImage: pizza.pizzaToppingImage ?? [], pizzaFullImage: pizza.getPizzaFullImageUrl() ?? nil, pizzaThumbnail: pizza.getPizzaThumbnailUrl() ?? nil, pizzaPrice: pizza.pizzaPrice ?? 0.00, pizzaQuantity: pizza.pizzaQuantity ?? 0.00)
                    
            self.dominoPizzaDetailView?.setPizzaDetail(pizza: mappedPizzaDetail)
                    
            self.dominoPizzaDetailView?.stopLoading()
                    
            }, onFailure: {(errorMessage) in
                    print(errorMessage)
    
                    self.dominoPizzaDetailView?.stopLoading()
            })
                
            }
        }
        else{
            self.dominoPizzaDetailView?.stopLoading()
            self.dominoPizzaDetailView?.setEmptyPizzaDetail(errorMessage: "No internet connection.")
        }
    }
    
    
    
    func getAddToCart(model: PizzaDetailViewData){

        self.totalQuantity += 1.0
    
        cartService.addToCart(model: model,
        onSuccess: { pizza in
            self.dominoPizzaDetailView?.showAddToCartDialog(title:"Successful Added To Cart",message: "Added \(model.pizzaName ?? "") to the cart Successfully.")
        },onFailure: {(errorMessage) in
            
            self.dominoPizzaDetailView?.showAddToCartDialog(title:"Item Already Existed In Cart",message: errorMessage)
            print(errorMessage)
        })
        
    }
    

    func addToCartPersistence(){
        
    }
        
}


