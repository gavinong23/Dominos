//
//  Global.swift
//  Dominos
//
//  Created by Gavin Ong on 5/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation


class Global{
    
    var sharedGlobalCart = [PizzaDetailViewData]()
    
    class var sharedManager: Global {
        struct Static {
            static let instance = Global()
        }
        return Static.instance
    }
    
}
