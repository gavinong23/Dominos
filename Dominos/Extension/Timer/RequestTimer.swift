//
//  RequestTimer.swift
//  Dominos
//
//  Created by Gavin Ong on 30/5/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation

fileprivate extension Selector {
    static let getAllPizzas = #selector(DominoHomePresenter.getPizzas)
}


class RequestTimer{
    
    static let sharedTimer: RequestTimer = {
        let timer = RequestTimer()
        return timer
    }()
    
    var timer : Timer?
    
    init(){
        
    }
    
    //typealias requestSelector = () -> Void
    
    func startRequestTimer(){
//        if(timer == nil){
        timer = Timer.scheduledTimer(timeInterval: Config.Timer.GetAllPizzaReqInterval, target: self, selector:.getAllPizzas, userInfo: nil, repeats: true)
            print("start request Timer")
        
//        }
    }
    
    func stopRequestTimer(){
        if timer != nil{
            
            timer?.invalidate()
            timer = nil
        }
        print("stop request timer")
    }
    
}
