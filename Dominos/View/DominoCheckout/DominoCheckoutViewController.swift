//
//  DominoCheckout.swift
//  Dominos
//
//  Created by Gavin Ong on 8/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation
import UIKit

enum EnumPaymentType {
    case cc
    case cod
}

class DominoCheckoutViewController:UIViewController {
//    let paymentView:UIView = UIView()
//    
//    let creditCardView = CreditCardView()
//    creditCardView.setCC(number: "231312313123123")
//    let codView = CodView()
//
//    if EnumPaymentType == .cc {
//        paymentView = creditCardView
//    } else if EnumPaymentType == .cod {
//        paymentView = codView
//    }

    @IBOutlet weak var shipmentDetailsContainerView: UIView!
    
    @IBOutlet weak var orderSummaryContainerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupShipmentDetailsView()
        setupOrderSummaryView()
        

    }
    
    func setupShipmentDetailsView(){
        let containerSize = self.shipmentDetailsContainerView.bounds
        let shipmentDetailsUIView = ShipmentDetailsUIView(frame: CGRect(x: 0, y: 0, width: containerSize.width, height: containerSize.height))
        //        shipmentDetailsContainerView = shipmentDetailsUIView
        shipmentDetailsContainerView.addSubview(shipmentDetailsUIView)
    }
    
    func setupOrderSummaryView(){
        let containerSize = self.orderSummaryContainerView.bounds
        let orderSummaryUIView = OrderSummaryUIView(frame: CGRect(x: 0, y: 0, width: containerSize.width, height: containerSize.height))
        orderSummaryUIView.addSubview(orderSummaryUIView)
    }
    


}
