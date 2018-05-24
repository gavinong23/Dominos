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

class DominoListingModel{
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
    
    func getPizzaThumbnailUrl() -> URL? {
        var url:URL?

        if let pizzaThumbnail = self.pizzaThumbnail {
            let urlString = [baseImageUrl, pizzaThumbnail].joined()
            url = URL(string: urlString)!
        }
        return url
    }
    
}