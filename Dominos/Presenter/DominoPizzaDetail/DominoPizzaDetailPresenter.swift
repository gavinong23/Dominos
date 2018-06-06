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
        
        //print(model)
        
        cartService.addToCart(model: model)
        
        
        //let cartSingleton = Global.sharedManager
        //cartSingleton.item.
           // globalCartArray.append(model)
        
        //cartService.addToCart(model: model)
        
        
//        let userDefaults = UserDefaults.standard
//
//        if userDefaults.object(forKey: Config.preferenceKey.cartModels) != nil{
//            userDefaults.removeObject(forKey: Config.preferenceKey.cartModels)
//
//            cartSingleton.sharedGlobalCart.append(model)
//
//            print(cartSingleton.sharedGlobalCart.count)
//
//            let encoder = JSONEncoder()
//
//            if let encoded = try? encoder.encode(cartSingleton.sharedGlobalCart){
//                userDefaults.set(encoded, forKey: Config.preferenceKey.cartModels)
//            }
//
//        }else{
//
//            cartSingleton.sharedGlobalCart.append(model)
//
//            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: cartSingleton.sharedGlobalCart)
//            userDefaults.set(encodedData, forKey: Config.preferenceKey.cartModels)
//            userDefaults.synchronize()
//        }
        
       // create an empty array and keep append element go into it.
        
//                    let cartModels = NSKeyedUnarchiver.unarchiveObject(with: data as! Data)
//                    print("myPeopleList: \(cartModels)")
//                    userDefaults.set(cartModels, forKey: Config.preferenceKey.cartModels)
//
//
//                userDefaults.removeObject(forKey: Config.preferenceKey.cartModels)
//
//        if userDefaults.object(forKey: Config.preferenceKey.cartModels) != nil{
//            let decoded  = userDefaults.object(forKey: Config.preferenceKey.cartModels) as! Data
//
//            if var decodedPizzaCartData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? [PizzaDetailViewData]{
//                //var decodedPizzaCartData = decodedPizzaCartData
//                decodedPizzaCartData.append(model)
//
//                let encoder = JSONEncoder()
//
//                if let encoded = try? encoder.encode(decodedPizzaCartData) {
//                    userDefaults.set(encoded, forKey: Config.preferenceKey.cartModels)
//
//                }
//            }
//
//
//
//        }
//
        // self.dominoPizzaDetailView?.routeTo(screen: .pizzaCart(model: model))
   
        
        
        //print(decodedPizzaCartData)
//        let jsonEncoder = JSONEncoder()
        
//        var jsonData : Data?
        
//        do{jsonData = try jsonEncoder.encode(decodedPizzaCartData)}catch let error as NSError{}
        
//        let encodedData = NSKeyedArchiver.archivedData(withRootObject: decodedPizzaCartData)
        
       
        
        // JSONEncoder.encode(<#T##JSONEncoder#>)
        //        let propertyListCartItems = decodedPizzaCartData.map{$0.propertyListRepresentation}
        
        //        userDefaults.set(propertyListCartItems, forKey: Config.preferenceKey.cartModels)
        
        
   
    }
    
    func addToCartPersistence(){
        
    }
        
}


