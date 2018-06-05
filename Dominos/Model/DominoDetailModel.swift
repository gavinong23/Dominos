//
//  DominoDetailModel.swift
//  Dominos
//
//  Created by Gavin Ong on 22/5/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation
import SwiftyJSON


class DominoDetailModel{
    
    let baseImageUrl = Config.Url.BASE_IMAGE_URL
    var pizzaID: String?
    var pizzaName: String?
    var pizzaDesc: String?
    var pizzaToppingImage: [EnumPizzaToppings]?
    var pizzaFullImage: String?
    var pizzaThumbnail: String?
    var pizzaPrice: Float?
    var pizzaQuantity: Double?
    
    required init(JSON : JSON){
        
        
        self.pizzaID = JSON["pizzaID"].stringValue
        self.pizzaName = JSON["pizzaName"].stringValue
        self.pizzaDesc = JSON["pizzaDesc"].stringValue
        self.pizzaFullImage = JSON["pizzaImage"].stringValue
        self.pizzaThumbnail = JSON["pizzaThumbnail"].stringValue
        
        self.pizzaToppingImage = JSON["pizzaToppingImage"].arrayValue.map{
            EnumPizzaToppings(rawValue: $0.stringValue)!
        }
        
        self.pizzaPrice = JSON["pizzaPrice"].floatValue
        
        self.pizzaQuantity = 1.0
    
    }
    
//    public func encode(with aCoder: NSCoder) {
//        
//        if let pizzaID = pizzaID{
//            aCoder.encode(pizzaID, forKey:"pizzaID")
//        }
//        
//        if let pizzaName = pizzaName{
//            
//            aCoder.encode(pizzaName, forKey:"pizzaName")
//        }
//        
//        if let pizzaDesc = pizzaDesc{
//            
//            aCoder.encode(pizzaDesc, forKey:"pizzaDesc")
//        }
//   
//            
//            aCoder.encode(pizzaToppingImage, forKey:"pizzaToppingImage")
//        
//        
//        if let pizzaFullImage = pizzaFullImage{
//            
//            aCoder.encode(pizzaFullImage, forKey:"pizzaFullImage")
//        }
//        
//        if let pizzaThumbnail = pizzaThumbnail{
//            
//            aCoder.encode(pizzaThumbnail, forKey:"pizzaThumbnail")
//        }
//        
//        if let pizzaPrice = pizzaPrice{
//            
//            aCoder.encode(pizzaPrice, forKey:"pizzaPrice")
//        }
//
//    }
//    
//    required init(coder aDecoder: NSCoder) {
//        pizzaID = aDecoder.decodeObject(forKey:"pizzaID") as? String
//        pizzaName = aDecoder.decodeObject(forKey:"pizzaName") as? String
//        pizzaDesc = aDecoder.decodeObject(forKey:"pizzaDesc") as? String
//        pizzaToppingImage = aDecoder.decodeObject(forKey:"pizzaToppingImage") as? [EnumPizzaToppings]
//        pizzaFullImage = aDecoder.decodeObject(forKey:"pizzaFullImage") as? String
//        pizzaThumbnail = aDecoder.decodeObject(forKey:"pizzaThumbnail") as? String
//        pizzaPrice = aDecoder.decodeFloat(forKey: "pizzaPrice")
    //    pizzaQuantity = aDecoder.decodeDouble(forKey: "pizzaQuantity")
//        
////        self.init(pizzaID: pizzaID, pizzaName: pizzaName, pizzaDesc: pizzaDesc, pizzaToppingImage: pizzaToppingImage, pizzaFullImage: pizzaFullImage, pizzaThumbnail: pizzaThumbnail, pizzaPrice: pizzaPrice)
//    }
    
    

    
    func getPizzaFullImageUrl() -> URL? {
        var url:URL?
        
        if let pizzaFullImage = self.pizzaFullImage {
            let urlString = [baseImageUrl, pizzaFullImage].joined()
            url = URL(string: urlString)!
        }
        return url
    }
    
    func getPizzaThumbnailUrl() -> URL? {
        var url:URL?
        
        if let pizzaThumbnail = self.pizzaThumbnail {
            let urlString = [baseImageUrl, pizzaThumbnail].joined()
            url = URL(string: urlString)!
        }
        return url
    }

    

    
    
}
