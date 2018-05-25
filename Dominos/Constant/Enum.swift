//
//  Enum.swift
//  Dominos
//
//  Created by Gavin Ong on 23/5/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation
import UIKit

enum EnumPizzaToppings : String{
    case all = "0"
    case samyeang = "1"
    case chili = "2"
    case pesto = "3"
    case secret = "4"
    case tomato = "5"
    case smokey = "6"
    case chicken = "7"
    case meat = "8"
    case shrimp = "9"
    case veggie = "10"
    
    func toppingImage() -> UIImage{
        switch self{
        
        case .all:
            return UIImage()
        case .tomato:
            return R.image.icon_sauceTomato()!
        case .chili:
            return R.image.icon_sauceChili()!
        case .veggie:
            return R.image.icon_toppingVeggie()!
        case .samyeang:
            return R.image.icon_samyeangsaucered()!
        case .smokey:
            return R.image.icon_smokey()!
        case .chicken:
            return R.image.icon_toppingChicken()!
        case .meat:
            return R.image.icon_toppingMeat()!
        case .shrimp:
            return R.image.icon_toppingShrimp()!
        case .pesto:
            return R.image.icon_saucePesto()!
        case .secret:
            return R.image.icon_sauceSecret()!
        }
    }
    
    func toppingString() -> String{
        switch self{
            case .all:
                return "All"
            case .samyeang:
                return "Samyeang"
            case .chili:
                return "Chili"
            case .pesto:
                return "Pesto"
            case .secret:
                return "Secret"
            case .tomato:
                return "Tomato"
            case .smokey:
                return "Smokey"
            case .chicken:
                return "Chicken"
            case .meat:
                return "Meat"
            case .shrimp:
                return "Shrimp"
            case .veggie:
                return "Veggie"
        }
    }
    
    public static func cases() -> AnySequence<EnumPizzaToppings> {
        return AnySequence { () -> AnyIterator<EnumPizzaToppings> in
            var raw = 0
            return AnyIterator {
                let current: EnumPizzaToppings = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else {
                    return nil
                }
                raw += 1
                return current
            }
        }
    }
    
    public static var allValues: [EnumPizzaToppings] {
        return Array(self.cases())
    }
}
