////
////  PizzaToppingEnum.swift
////  Dominos
////
////  Created by Gavin Ong on 5/6/18.
////  Copyright © 2018 OngBoonFong. All rights reserved.
////
//
//import Foundation
//
//
//
//extension EnumPizzaToppings{
//    
//    enum CodingKeys: String, CodingKey {
//        case all = "0"
//        case samyeang = "1"
//        case chili = "2"
//        case pesto = "3"
//        case secret = "4"
//        case tomato = "5"
//        case smokey = "6"
//        case chicken = "7"
//        case meat = "8"
//        case shrimp = "9"
//        case veggie = "10"
//    }
//    
//    enum EnumPizzaToppingsCodingError: Error {
//        case decoding(String)
//    }
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        
//        if let value = try? values.decodeIfPresent(String.self, forKey: .all){
//            self = .all
//            return
//        }
//
//        if let value = try? values.decodeIfPresent(String.self, forKey: .samyeang) {
//            self = .samyeang
//            return
//        }
//        if let value = try? values.decodeIfPresent(String.self, forKey: .chili) {
//            self = .chili
//            return
//        }
//        if let value = try? values.decodeIfPresent(String.self, forKey: .pesto) {
//            self = .pesto
//            return
//        }
//        
//        if let value = try? values.decodeIfPresent(String.self, forKey: .secret) {
//            self = .secret
//            return
//        }
//        if let value = try? values.decodeIfPresent(String.self, forKey: .tomato) {
//            self = .tomato
//            return
//        }
//        if let value = try? values.decodeIfPresent(String.self, forKey: .smokey) {
//            self = .smokey
//            return
//        }
//        if let value = try? values.decodeIfPresent(String.self, forKey: .chicken) {
//            self = .chicken
//            return
//        }
//        if let value = try? values.decodeIfPresent(String.self, forKey: .meat) {
//            self = .meat
//            return
//        }
//        if let value = try? values.decodeIfPresent(String.self, forKey: .shrimp) {
//            self = .shrimp
//            return
//        }
//        
//        if let value = try? values.decodeIfPresent(String.self, forKey: .veggie) {
//            self = .veggie
//            return
//        }
//    
//        throw EnumPizzaToppingsCodingError.decoding("Whoops! \(dump(values))")
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        switch self{
//            
//        case .all:
//            try container.encode(EnumPizzaToppings.all.rawValue, forKey: .all)
//        case .samyeang:
//            try container.encode(EnumPizzaToppings.samyeang.rawValue, forKey: .samyeang)
//        case .chili:
//            try container.encode(EnumPizzaToppings.chili.rawValue, forKey: .chili)
//        case .pesto:
//            try container.encode(EnumPizzaToppings.pesto.rawValue, forKey: .pesto)
//        case .secret:
//            try container.encode(EnumPizzaToppings.secret.rawValue, forKey: .secret)
//        case .tomato:
//            try container.encode(EnumPizzaToppings.tomato.rawValue, forKey: .tomato)
//        case .smokey:
//            try container.encode(EnumPizzaToppings.smokey.rawValue, forKey: .smokey)
//        case .chicken:
//            try container.encode(EnumPizzaToppings.chicken.rawValue, forKey: .chicken)
//        case .meat:
//            try container.encode(EnumPizzaToppings.meat.rawValue, forKey: .meat)
//        case .shrimp:
//            try container.encode(EnumPizzaToppings.shrimp.rawValue, forKey: .shrimp)
//        case .veggie:
//            try container.encode(EnumPizzaToppings.veggie.rawValue, forKey: .veggie)
//        }
//    }
//
//
//    
//    
//}
