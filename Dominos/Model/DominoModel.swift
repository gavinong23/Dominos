//
//  DominoModel.swift
//  Dominos
//
//  Created by Gavin Ong on 15/5/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

class DominoModel{
    let baseImageUrl = Config.Url.BASE_IMAGE_URL
    //var pizzaImg: [EnumPizzaImgs]?
    var pizzaImage: [String]?
    var pizzaName: String?
    var pizzaDesc: String?
    var pizzaToppingImage: [String]?
    var pizzaTopping: [String]?
    
    init (JSON:JSON){
        
        self.pizzaName = JSON["pizzaName"].stringValue
        self.pizzaImage = [JSON["pizzaImage"].stringValue]
        
        self.pizzaImage = [JSON["pizzaImage"][0].stringValue,JSON["pizzaImage"][1].stringValue]
        
        self.pizzaDesc = JSON["pizzaDesc"].stringValue
        //self.pizzaToppingImage = [JSON["pizzaToppingImage"].stringValue]

        //print(JSON["pizzaToppingImage"].arrayValue)
        
        self.pizzaToppingImage = JSON["pizzaToppingImage"].arrayValue.map{
            $0.stringValue
        }
        
        //print(self.pizzaToppingImage)
        
//        print(self.pizzaToppingImage)
        self.pizzaTopping = [JSON["pizzaTopping"].stringValue]
    }
    
    func getPizzaThumbnailUrl() -> URL? {
        var url:URL?

        if let pizzaImage = self.pizzaImage {
            let urlString = [baseImageUrl, pizzaImage[1]].joined()
            url = URL(string: urlString)!
        }
        return url
    }
    
    func getPizzaFullImageUrl() -> URL?{
        var url: URL?
        
        if let pizzaImage = self.pizzaImage{
            let urlString = [baseImageUrl, pizzaImage[0]].joined()
            url = URL(string: urlString)!
        }
        
        return url
    }
    
//    func getPizzaIconUrl() -> URL{
//        var url: URL?
//
//        if let pizzaToppingImage = self.pizzaToppingImage{
//            /let urlString = [baseImageUrl, pizzaToppingImage].joined()
//            url = URL(string: urlString)!
//        }
//    }
    
    func getPizzaIconUrl() -> [URL]?{
        var urls: [URL] = []

        for pizzaTopping in self.pizzaToppingImage!{
            let urlString = [baseImageUrl, pizzaTopping].joined()

            let pizzaToppingUrl = URL(string: urlString)!

            urls.append(pizzaToppingUrl)
        }

        return urls
    }
}
