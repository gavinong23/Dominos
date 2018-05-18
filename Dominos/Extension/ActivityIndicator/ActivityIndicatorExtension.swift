//
//  ActivityIndicatorExtension.swift
//  Dominos
//
//  Created by OngBoonFong on 02/05/2018.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView


var activityIndicator : NVActivityIndicatorView? = nil

extension UIViewController: NVActivityIndicatorViewable {
    
    func presentLoadingView() {
        activityIndicator = NVActivityIndicatorView(frame: CGRect(x:0,y:0,width: 50, height: 50), type: .ballRotateChase, color: UIColor.gray, padding: 0)
        activityIndicator?.center = self.view.center
        self.view.addSubview(activityIndicator!)
        self.view.bringSubview(toFront:  activityIndicator!)
        activityIndicator?.startAnimating()
       
    }
    
    func dismissLoadingView() {
        activityIndicator?.stopAnimating()
    }
}
