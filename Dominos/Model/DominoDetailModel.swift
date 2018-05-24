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
    
    
    init(JSON : JSON){
        self.pizzaID = JSON["pizzaID"].stringValue
        self.pizzaName = JSON["pizzaName"].stringValue
        self.pizzaDesc = JSON["pizzaDesc"].stringValue
        self.pizzaFullImage = JSON["pizzaImage"].stringValue
        
        self.pizzaToppingImage = JSON["pizzaToppingImage"].arrayValue.map{
            EnumPizzaToppings(rawValue: $0.stringValue)!
        }
    }
    
    func getPizzaFullImageUrl() -> URL? {
        var url:URL?
        
        if let pizzaFullImage = self.pizzaFullImage {
            let urlString = [baseImageUrl, pizzaFullImage].joined()
            url = URL(string: urlString)!
        }
        return url
    }
    
    
}
