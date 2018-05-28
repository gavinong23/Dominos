//
//  BaseViewController.swift
//  Dominos
//
//  Created by Gavin Ong on 25/5/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController:UIViewController{
    
    var noInternetConnectionView = UIView()
    
    func abc(){
        print("THIS IS FROM BASE VIEWCONTROLLER")
        super.viewDidLoad()
        //self.
    }
    
    func addErrorView(errorMessage: String){
        
        self.view.bounds = view.bounds
        self.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let fullWidth = self.view.bounds.width
        let fullHeight = self.view.bounds.height
        
        noInternetConnectionView = UIView(frame: CGRect(x:0,y:0, width: fullWidth , height: fullHeight))

        let noInternetLabel = UILabel(frame: CGRect(x:0, y: 0, width: fullWidth, height: fullHeight ))

        noInternetLabel.text = errorMessage
        noInternetLabel.numberOfLines = 2
        noInternetLabel.backgroundColor = UIColor.clear
        noInternetLabel.textAlignment = .center
        noInternetLabel.textColor = UIColor.black
        
        noInternetLabel.center = noInternetConnectionView.center
        noInternetConnectionView.addSubview(noInternetLabel)
        
        self.view.addSubview(noInternetConnectionView)
        
        self.didMove(toParentViewController: self)
        
   
    }
    
    func removeErrorView(){
      self.noInternetConnectionView.removeFromSuperview()
    }
    
}
