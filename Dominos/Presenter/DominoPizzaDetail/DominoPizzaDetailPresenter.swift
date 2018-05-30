//
//  DominoPizzaDetailPresenter.swift
//  Dominos
//
//  Created by Gavin Ong on 22/5/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation


struct PizzaDetailViewData{
    var pizzaID: String?
    var pizzaName: String?
    var pizzaDesc: String?
    var pizzaToppingImage: [EnumPizzaToppings]?
    var pizzaFullImage: URL?
    var pizzaThumbnail: URL?
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
    
    private let pizzaService : PizzaService
    weak private var dominoPizzaDetailView : DominoPizzaDetailViewType?
    
    init(pizzaService: PizzaService) {
        self.pizzaService = pizzaService
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
        
                let mappedPizzaDetail = PizzaDetailViewData(pizzaID: pizza.pizzaID ?? "", pizzaName: pizza.pizzaName ?? "", pizzaDesc: pizza.pizzaDesc ?? "", pizzaToppingImage: pizza.pizzaToppingImage ?? [], pizzaFullImage: pizza.getPizzaFullImageUrl() ?? nil, pizzaThumbnail: pizza.getPizzaThumbnailUrl() ?? nil)
                    
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
        self.dominoPizzaDetailView?.routeTo(screen: .pizzaCart(model: model))
    }
        
}


