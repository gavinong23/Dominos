//
//  DominoHomePresenter.swift
//  Dominos
//
//  Created by OngBoonFong on 30/04/2018.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation

enum EnumDominoHomeRoute{
    case pizzaDetail(model:PizzasViewData)
    
    func segueID() -> String{
        switch self{
        case .pizzaDetail:
                return R.segue.dominoHomeViewController.pizzaHomeToPizzaHomeDetailID.identifier
        }
    }
}

struct PizzasViewData{
    let pizzaThumbnail: URL?
    let pizzaFull: URL?
    let pizzaName: String?
    let pizzaDesc: String?
    let pizzaToppingImage: [URL]?
    let pizzaTopping: [String]?

}

class DominoHomePresenter{
    
    private let pizzaService: PizzaService
    weak private var dominoPizzaHomeView : DominoPizzaHomeViewType?
    
    init(pizzaService: PizzaService) {
        self.pizzaService = pizzaService
    
    }
    
    func attachView(view: DominoPizzaHomeViewType){
        dominoPizzaHomeView = view
    }
    
    func detachView(){
        dominoPizzaHomeView = nil
    }
    
    
    func getPizzas(){
        self.dominoPizzaHomeView?.startLoading()
        
        pizzaService.callAPIGetPizzas(
            onSuccess: {(pizzas) in
                
                self.dominoPizzaHomeView?.stopLoading()
                
                if pizzas.count == 0{
                    self.dominoPizzaHomeView?.setEmptyPizza()
                }else{
                
                    let mappedPizzas = pizzas.map{
                        return PizzasViewData(pizzaThumbnail:$0.getPizzaThumbnailUrl(),pizzaFull: $0.getPizzaFullImageUrl(),pizzaName: $0.pizzaName ?? "", pizzaDesc: $0.pizzaDesc ?? "", pizzaToppingImage: $0.getPizzaIconUrl(), pizzaTopping: $0.pizzaTopping ?? [])
                    }
                    self.dominoPizzaHomeView?.setPizzas(pizzas: mappedPizzas)
                }
            }, onFailure: { (errorMessage) in
                print(errorMessage)
                self.dominoPizzaHomeView?.stopLoading()
            })
    }
    


    
    func getPizzaDetail(model:PizzasViewData){
//        print(.pizzaDetail)
        dominoPizzaHomeView?.routeTo(screen: .pizzaDetail(model: model))
    }
    
    
}
