//
//  Domino.swift
//  Dominos
//
//  Created by OngBoonFong on 26/04/2018.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation
import UIKit

enum EnumPizzaToppings{
    case tomato
    case chili
    case veggie
    case samyeang
    case smokey
    case chicken
    case meat
    case shrimp
    case pesto
    case secret
    
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

enum EnumPizzaImgs{
    case thumbnailPlainCheese
    case thumbnailSambalVeggie
    case thumbnailSpicySambal
    case thumbnailUltimHawaiian
    case thumbnailVegieFiesta
    case thumbnailVegieGalore
    case thumbnailSamyeangChicken
    case thumbnailSamyeangTuna
    
    case fullPlainCheese
    case fullSambalVeggie
    case fullSpicySambal
    case fullUltimHawaiian
    case fullVegieFiesta
    case fullVegieGalore
    case fullSamyeangChicken
    case fullSamyeangTuna
    
    func pizzaImage() -> UIImage{
        switch self{
            case .thumbnailPlainCheese:
                return R.image.thumbnail_pizzaFullPlainCheese()!
            case .thumbnailSambalVeggie:
                return R.image.thumbnail_pizzaSambalVeggie()!
            case .thumbnailSpicySambal:
                return R.image.thumbnail_pizzaSpicySambal()!
            case .thumbnailUltimHawaiian:
                return R.image.thumbnail_pizzaUltimHawaiian()!
            case .thumbnailVegieFiesta:
                return R.image.thumbnail_pizzaVegieFiesta1()!
            case .thumbnailVegieGalore:
                return R.image.thumbnail_pizzaVegieFiesta1()!
            case .thumbnailSamyeangChicken:
                return R.image.thumbnail_samyeangChickenPizza()!
            case .thumbnailSamyeangTuna:
                return R.image.thumbnail_samyeangChickenPizza()!
            case .fullPlainCheese:
                return R.image.full_pizzaFullPlainCheese()!
            case .fullSambalVeggie:
                return R.image.full_pizzaSambalVeggie()!
            case .fullSpicySambal:
                return R.image.full_pizzaSpicySambal()!
            case .fullUltimHawaiian:
                return R.image.full_pizzaUltimHawaiian()!
            case .fullVegieFiesta:
                return R.image.full_pizzaVegieFiesta()!
            case .fullVegieGalore:
                return R.image.full_pizzaVegieGalore()!
            case .fullSamyeangChicken:
                return R.image.full_samyeangChickenPizza()!
            case .fullSamyeangTuna:
                return R.image.full_samyeangTunaPizza()!
        }
    }
    
}

class DominoModelss: NSObject{
    
//    var pizzaImg: [EnumPizzaImgs]?
//    var pizzaName: String?
//    var pizzaDesc: String?
//    var pizzaToppingImg: [EnumPizzaToppings]?
//    var pizzaType: [String]?
//
//
//
//    init(pizzaImg:[EnumPizzaImgs],pizzaName : String, pizzaDesc: String, pizzaToppingImg:[EnumPizzaToppings],pizzaType:[String]){
//        self.pizzaImg = pizzaImg
//        self.pizzaName = pizzaName
//        self.pizzaDesc = pizzaDesc
//        self.pizzaToppingImg = pizzaToppingImg
//        self.pizzaType = pizzaType
//    }
    
}
