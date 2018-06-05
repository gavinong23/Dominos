//
//  DominoModel.swift
//  Dominos
//
//  Created by Gavin Ong on 15/5/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

class DominoListingModel : NSObject{
    let baseImageUrl = Config.Url.BASE_IMAGE_URL
    var pizzaID: String?
    var pizzaThumbnail: String?
    var pizzaName: String?
    var pizzaDesc: String?
    var pizzaToppingImage: [EnumPizzaToppings]?
    
    init (JSON:JSON){
        
        self.pizzaID = JSON["pizzaID"].stringValue
        
        self.pizzaName = JSON["pizzaName"].stringValue
        
        self.pizzaThumbnail = JSON["pizzaImage"].stringValue
        
        self.pizzaDesc = JSON["pizzaDesc"].stringValue
        
        self.pizzaToppingImage = JSON["pizzaToppingImage"].arrayValue.map{
                EnumPizzaToppings(rawValue: $0.stringValue)!
        }
        
    }
    
//    public func encode(with aCoder: NSCoder) {
//        aCoder.encode(pizzaID, forKey:"pizzaID")
//        aCoder.encode(pizzaThumbnail, forKey:"pizzaThumbnail")
//        aCoder.encode(pizzaName, forKey:"pizzaName")
//        aCoder.encode(pizzaDesc, forKey:"pizzaDesc")
//        aCoder.encode(pizzaToppingImage, forKey:"pizzaToppingImage")
//
//    }
//
//    required init(coder aDecoder: NSCoder) {
//        pizzaID = aDecoder.decodeObject(forKey:"pizzaID") as? String
//        pizzaName = aDecoder.decodeObject(forKey:"pizzaName") as? String
//        pizzaDesc = aDecoder.decodeObject(forKey:"pizzaDesc") as? String
//        pizzaToppingImage = aDecoder.decodeObject(forKey:"pizzaToppingImage") as? [EnumPizzaToppings]
//    }
    
    func getPizzaThumbnailUrl() -> URL? {
        var url:URL?

        if let pizzaThumbnail = self.pizzaThumbnail {
            let urlString = [baseImageUrl, pizzaThumbnail].joined()
            url = URL(string: urlString)!
        }
        return url
    }
    
}
