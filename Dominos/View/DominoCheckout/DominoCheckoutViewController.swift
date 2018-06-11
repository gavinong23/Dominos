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
    
    @IBOutlet weak var creditCardButton: UIButton!

    @IBOutlet weak var codButton: UIButton!
    
    var offsetY:CGFloat = 0

    @IBOutlet weak var placeOrderButton: UIButton!
    
    var paymentMethodUIView = PaymentMethodUIView()
  
    
    var subTotal = String()
    var deliveryFee = String()
    var totalAmount = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupShipmentDetailsView()
        setupOrderSummaryView()
   
        setupPaymentMethodView(paymentType: .cc)
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
        orderSummaryUIView.setupPrice(subTotal: subTotal, deliveryFee: deliveryFee, total: totalAmount)
    }
    
    func setupPaymentMethodView(paymentType: EnumPaymentType){
        let containerSize = self.paymentMethodContainerView.bounds
        paymentMethodUIView = PaymentMethodUIView(frame: CGRect(x:0, y:0, width: containerSize.width, height: containerSize.height))
        
        paymentMethodUIView.showPaymentView(paymentType: paymentType)
       // self.creditCardButton.isEnabled = false
       // self.codButton.isEnabled = true
        
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
    
    
    @IBAction func placeOrderButtonOnClick(_ sender: Any) {
        self.dominoCheckoutPresenter.placeOrder()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardFrameChangeNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
//    }
//
//    @objc func keyboardFrameChangeNotification(notification: Notification) {
//
//        if let userInfo = notification.userInfo {
//            let endFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect
//            let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double ?? 0
//            let animationCurveRawValue = (userInfo[UIKeyboardAnimationCurveUserInfoKey] as? Int) ?? Int(UIViewAnimationOptions.curveEaseInOut.rawValue)
//            let animationCurve = UIViewAnimationOptions(rawValue: UInt(animationCurveRawValue))
//            if let _ = endFrame, endFrame!.intersects(self.paymentMethodUIView.ccvTextField.frame) {
//                self.offsetY = self.paymentMethodUIView.ccvTextField.frame.maxY - endFrame!.minY
//                UIView.animate(withDuration: animationDuration, delay: TimeInterval(0), options: animationCurve, animations: {
//                    self.paymentMethodUIView.ccvTextField.frame.origin.y = self.paymentMethodUIView.ccvTextField.frame.origin.y - self.offsetY
//                }, completion: nil)
//            } else {
//                if self.offsetY != 0 {
//                    UIView.animate(withDuration: animationDuration, delay: TimeInterval(0), options: animationCurve, animations: {
//                        self.paymentMethodUIView.ccvTextField.frame.origin.y = self.paymentMethodUIView.ccvTextField.frame.origin.y + self.offsetY
//                        self.offsetY = 0
//                    }, completion: nil)
//                }
//            }
//        }
//    }
    

    
}

extension DominoCheckoutViewController: DominoCheckoutViewType{
    
    func showPaymentView(paymentType: EnumPaymentType){
        self.setupPaymentMethodView(paymentType: paymentType)
    }
    
    func disableCreditCardButton(){
        self.creditCardButton.isEnabled = false
        self.codButton.isEnabled = true
    }
    
    func disableCodButton(){
        self.codButton.isEnabled = false
        self.creditCardButton.isEnabled = true
    }
    
    func showAlertBox(title:String,message:String){
        let alert = UIAlertController(title: title , message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showSuccessAlertBox(title: String, message: String){
          let alert = UIAlertController(title: title , message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
            self.dominoCheckoutPresenter.routeTo()
        }))
        self.present(alert,animated:true, completion:nil)
    }
    
    
    func routeTo(screen:DominoCheckoutEnumRoute){
 
//        switch screen{
//        case .pizzaHome:
//            self.performSegue(withIdentifier: screen.segueID(), sender: self)
//        }
        
        let mainViewController: UINavigationController = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "DominoHomeViewController") as! UINavigationController
        self.present(mainViewController, animated: false, completion: nil)

    }
    
    func checkIsNullCreditCard() -> Bool{
        
        var isNull: Bool = false
        
        if self.paymentMethodUIView.cardHolderNameTextField.text == ""{
            isNull = true
        }else if self.paymentMethodUIView.cardNumberTextField.text == ""{
            isNull = true
        }else if self.paymentMethodUIView.ccvTextField.text == ""{
            isNull = true
        }else if self.paymentMethodUIView.expirationDateTextField.text == ""{
            isNull = true
        }
        
        return isNull
    }
    
}
