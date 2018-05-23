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
}
