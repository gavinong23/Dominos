//
//  dominoListingModel.swift
//  Dominos
//
//  Created by Gavin Ong on 4/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation
import UIKit



//extension PizzaDetailViewData : Decodable{
//
//
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//    }
//
//}
//var pizzaID: String?
//var pizzaName: String?
//var pizzaDesc: String?
//var pizzaToppingImage: [EnumPizzaToppings]?
//var pizzaFullImage: URL?
//var pizzaThumbnail: URL?
//var pizzaPrice: Float?
//var pizzaQuantity: Double?



extension PizzaDetailViewData : Codable{
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
//        let toppingEnumValues = try decoder.container(keyedBy: EnumPizzaToppings.CodingKeys.self)

        pizzaID = try values.decode(String.self, forKey: .pizzaID)
        pizzaName = try values.decode(String.self, forKey: .pizzaName)
        pizzaDesc = try values.decode(String.self, forKey: .pizzaDesc)
        pizzaToppingImage = try values.decode([EnumPizzaToppings].self, forKey: .pizzaToppingImage)
//        pizzaToppingImage = try [EnumPizzaToppings].init(from: decoder)
//        pizzaToppingImage = try values.nestedContainer(keyedBy: , forKey: .pizzaToppingImage)
        pizzaFullImage = try values.decode(URL.self, forKey: .pizzaFullImage)
        pizzaThumbnail = try values.decode(URL.self, forKey: .pizzaThumbnail)
        pizzaPrice = try values.decode(Float.self, forKey: .pizzaPrice)
        pizzaQuantity = try values.decode(Double.self, forKey: .pizzaQuantity)

        
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        name = try values.decode(String.self, forKey: .name)
//        billingAddress = try BillingAddress(from: decoder)
    }

    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(name, forKey: .name)
//        try container.encode(billingAddress.district, forKey: .district)
//        try container.encode(billingAddress.subDistrict, forKey: .subDistrict)
//        try container.encode(billingAddress.country, forKey: .country)
//        try container.encode(billingAddress.postalCode, forKey: .postalCode)
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        if let pizzaID = pizzaID{
            try container.encode(pizzaID, forKey:.pizzaID)
        }
        
        if let pizzaName = pizzaName{
            try container.encode(pizzaName, forKey: .pizzaName)
        }
      
        if let pizzaDesc = pizzaDesc{
            try container.encode(pizzaDesc, forKey: .pizzaDesc)
        }
        
        if let pizzaToppingImage = pizzaToppingImage{
            try container.encode(pizzaToppingImage, forKey: .pizzaToppingImage)
        }
        
        if let pizzaFullImage = pizzaFullImage{
            try container.encode(pizzaFullImage, forKey: .pizzaFullImage)
        }
        
        if let pizzaThumbnail = pizzaThumbnail{
            try container.encode(pizzaThumbnail, forKey: .pizzaThumbnail)
        }
        
        if let pizzaPrice = pizzaPrice{
            try container.encode(pizzaPrice, forKey: .pizzaPrice)
        }
       
        if let pizzaQuantity = pizzaQuantity{
            try container.encode(pizzaQuantity, forKey: .pizzaQuantity)
        }
    }
}
