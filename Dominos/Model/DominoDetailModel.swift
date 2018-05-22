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
    var pizzaToppingImage: [String]?
    var pizzaFullImage: String?
    
    
    init(JSON : JSON){
        self.pizzaID = JSON["pizzaID"].stringValue
        self.pizzaName = JSON["pizzaName"].stringValue
        self.pizzaDesc = JSON["pizzaDesc"].stringValue
        self.pizzaFullImage = JSON["pizzaImage"].stringValue
        self.pizzaToppingImage = [JSON["pizzaToppingImage"].stringValue]
    }
    
    func getPizzaFullImageUrl() -> URL? {
        var url:URL?
        
        if let pizzaFullImage = self.pizzaFullImage {
            let urlString = [baseImageUrl, pizzaFullImage].joined()
            url = URL(string: urlString)!
        }
        return url
    }
    
    func getPizzaIconUrl() -> [URL]?{
        var urls: [URL] = []
        
        for pizzaToppingImage in self.pizzaToppingImage!{
            let urlString = [baseImageUrl, pizzaToppingImage].joined()
            
            let pizzaToppingUrl = URL(string: urlString)!
            
            urls.append(pizzaToppingUrl)
        }
        
        return urls
    }
    
    
    
    
}
