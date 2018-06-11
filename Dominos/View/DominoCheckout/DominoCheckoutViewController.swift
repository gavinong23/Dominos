//
//  DominoCheckout.swift
//  Dominos
//
//  Created by Gavin Ong on 8/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation
import UIKit



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
    
    private let dominoCheckoutPresenter = DominoCheckoutPresenter()

    @IBOutlet weak var shipmentDetailsContainerView: UIView!
    
    @IBOutlet weak var orderSummaryContainerView: UIView!
    
    @IBOutlet weak var paymentMethodContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupShipmentDetailsView()
        setupOrderSummaryView()
        //setupPaymentMethodView()
    

    }
    
    func setupView(){
      dominoCheckoutPresenter.attachView(view: self)
    }
    
    func setupShipmentDetailsView(){
        let containerSize = self.shipmentDetailsContainerView.bounds
        let shipmentDetailsUIView = ShipmentDetailsUIView(frame: CGRect(x: 0, y: 0, width: containerSize.width, height: containerSize.height))
        self.shipmentDetailsContainerView.addSubview(shipmentDetailsUIView)
    }
    
    func setupOrderSummaryView(){
        let containerSize = self.orderSummaryContainerView.bounds
        let orderSummaryUIView = OrderSummaryUIView(frame: CGRect(x: 0, y: 0, width: containerSize.width, height: containerSize.height))
        self.orderSummaryContainerView.addSubview(orderSummaryUIView)
    }
    
    func setupPaymentMethodView(paymentType: EnumPaymentType){
        let containerSize = self.paymentMethodContainerView.bounds
        let paymentMethodUIView = PaymentMethodUIView(frame: CGRect(x:0, y:0, width: containerSize.width, height: containerSize.height))
        
        paymentMethodUIView.showPaymentView(paymentType: paymentType)
        
        self.paymentMethodContainerView.addSubview(paymentMethodUIView)

    }
    
    
    @IBAction func creditCardMethodButtonOnClick(_ sender: Any) {
        
        dominoCheckoutPresenter.showPaymentView(paymentType: EnumPaymentType.cc)
    }
    
    @IBAction func codMethodButtonOnClick(_ sender: Any) {
        dominoCheckoutPresenter.showPaymentView(paymentType: EnumPaymentType.cod)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension DominoCheckoutViewController: DominoCheckoutViewType{
    
    func showPaymentView(paymentType: EnumPaymentType){
        self.setupPaymentMethodView(paymentType: paymentType)
    }
    
}
