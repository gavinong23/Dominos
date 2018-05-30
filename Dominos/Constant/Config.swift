//
//  Config.swift
//  Dominos
//
//  Created by OngBoonFong on 26/04/2018.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation
import UIKit


struct Config{
    
    struct Timer{
        static let timeInterval = 20.0
        static let GetAllPizzaReqInterval = 5.0
    }
    
    struct Url{
        static let API_BASE_URL = "https://ongbf-wa14.000webhostapp.com"
        static let BASE_IMAGE_URL = "https://ongbf-wa14.000webhostapp.com"
    }
    
    struct ApiKey{
        static let API_KEY = ["secret-key":"$2a$10$7fWTSD2Lf/curNInv.7dw.olYJLBwH/V2wVR4kFOh521KF6yoCGj."]
    }
    
}
