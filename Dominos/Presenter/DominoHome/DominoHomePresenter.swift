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
    let pizzaID: String?
    let pizzaThumbnail: URL?
    let pizzaName: String?
    let pizzaToppingImage: [EnumPizzaToppings]?
   
}

class DominoHomePresenter{
    
    private let pizzaService: PizzaService
    weak private var dominoPizzaHomeView : DominoPizzaHomeViewType?
    var timer : Timer?
    var mappedPizzas: [PizzasViewData]?
    
    init(pizzaService: PizzaService) {
        self.pizzaService = pizzaService
    
    }
    
    func attachView(view: DominoPizzaHomeViewType){
        dominoPizzaHomeView = view
    }
    
    func detachView(){
        dominoPizzaHomeView = nil
        
    }
    
    func pullToRefreshGetPizza(){
        if(Reachability.isConnectedToNetwork()){
            self.getPizzas()
            self.dominoPizzaHomeView?.stopLoading()
        }else{
            self.NoInternetConnectionGetPizza()
            self.dominoPizzaHomeView?.stopLoading()
        }
       
    }
    
    func NoInternetConnectionGetPizza(){
        self.dominoPizzaHomeView?.noConnection(errorMessage: "No Internet Connection. Please connect to the Internet and wait for awhile for the app to refresh.",isConnectedToNetwork: false)
        self.startRequestTimer()
    }
    
    
    func startRequestTimer(){
        if(timer == nil){
            timer = Timer.scheduledTimer(timeInterval: Config.Timer.GetAllPizzaReqInterval, target: self, selector: #selector(self.getPizzas), userInfo: nil, repeats: true)
            print("start request Timer")
        }
    }
    
    func stopRequestTimer(){

        if timer != nil{
            
            timer?.invalidate()
            timer = nil
        }
        print("stop request timer")
        self.dominoPizzaHomeView?.stopLoading()
    }
    
    @objc func getPizzas(){
//        self.dominoPizzaHomeView?.stopRefresher()
        self.dominoPizzaHomeView?.stopLoading()

        if(Reachability.isConnectedToNetwork()){
            
            self.dominoPizzaHomeView?.startLoading()
            pizzaService.callAPIGetPizzas(
                onSuccess: {(pizzas) in
                    
                    if pizzas.count == 0{
                        self.dominoPizzaHomeView?.stopLoading()
                       // self.dominoPizzaHomeView?.setEmptyPizza(errorMessage: "", isConnectedToNetwork: true)
                    }else{
                        
                        self.mappedPizzas = pizzas.map{
                            return PizzasViewData(pizzaID: $0.pizzaID ?? "",pizzaThumbnail:$0.getPizzaThumbnailUrl(),pizzaName: $0.pizzaName ?? "", pizzaToppingImage: $0.pizzaToppingImage)
                        }
                        
                        self.dominoPizzaHomeView?.setPizzas(pizzas: self.mappedPizzas!)
                        self.dominoPizzaHomeView?.showPickerView()
                        self.stopRequestTimer()
                    }
                     self.stopRefreshAndLoading()
                    
                }, onFailure: { (errorMessage) in
                    print(errorMessage)
                    self.stopRequestTimer()
                    self.stopRefreshAndLoading()
                  
            })
        }
        
    }
    
    func stopRefreshAndLoading(){
        self.dominoPizzaHomeView?.stopRefresher()
        self.dominoPizzaHomeView?.stopLoading()
    }
    
    func bindToppingToPicker(row: Int) -> String{
         return EnumPizzaToppings.allValues[row].toppingString()
    }
    
    func sortPizza(selectedTopping:EnumPizzaToppings){
        
//        if Reachability.isConnectedToNetwork(){
        
            if !(self.mappedPizzas?.isEmpty)!{
                var filterPizzas = self.mappedPizzas?.filter{
                    ($0.pizzaToppingImage?.contains(selectedTopping))!
                }
            
                if(selectedTopping.toppingString() == "All"){
                    filterPizzas = self.mappedPizzas
                }
                
                //Update Domino Home Collection View
                dominoPizzaHomeView?.filterPizza(pizzas: filterPizzas!)
            }
            
//        }else{
//            self.NoInternetConnectionGetPizza()
//        }
    }

    func getPizzaDetail(model:PizzasViewData){
//        if(Reachability.isConnectedToNetwork()){
            dominoPizzaHomeView?.routeTo(screen: .pizzaDetail(model: model))
//        }else{
//            self.NoInternetConnectionGetPizza()
//        }
    }
    
    
}
