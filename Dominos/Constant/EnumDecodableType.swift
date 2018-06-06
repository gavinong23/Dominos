//
//  EnumDecodableType.swift
//  Dominos
//
//  Created by Gavin Ong on 6/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation

enum ModelName : String {
    
    case pizzaDetailViewData = "PizzaDetailViewData"

    
    var modelType: AnyCodableType {
        switch self {
        case .pizzaDetailViewData:
            return AnyCodableType(PizzaDetailViewData.self)
        }
    }
}


