//
//  DominoDetailModel.swift
//  Dominos
//
//  Created by Gavin Ong on 22/5/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation
import SwiftyJSON


class UserAddressModel{
    
    var addressID: String?
    var address: String?
    
    required init(JSON : JSON){
        
        self.addressID = JSON["addressID"].stringValue
        self.address = JSON["address"].stringValue
    }
    
}
