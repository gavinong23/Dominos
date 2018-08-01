//
//  DominoCheckout.swift
//  Dominos
//
//  Created by Gavin Ong on 8/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces
import GoogleMaps



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
    
    private let dominoCheckoutPresenter = DominoCheckoutPresenter(pizzaService: PizzaService(),userService: UserService(), cartService: CartService())

    @IBOutlet weak var shipmentDetailsContainerView: UIView!
    
     var shipmentDetailsUIView  = ShipmentDetailsUIView()
    
    
    @IBOutlet weak var orderSummaryContainerView: UIView!
    
    var orderSummaryUIView = OrderSummaryUIView()
    
    @IBOutlet weak var paymentMethodContainerView: UIView!

    var paymentMethodUIView = PaymentMethodUIView()
    
    @IBOutlet weak var creditCardButton: UIButton!

    @IBOutlet weak var codButton: UIButton!
    
    var offsetY:CGFloat = 0
    
    var currentAddressID: String?

    @IBOutlet weak var placeOrderButton: UIButton!
    
    var shipmentDetails = ShipmentDetailsViewData()

    var subTotal = String()
    var deliveryFee = String()
    var totalAmount = String()
    
    //PayPal
    
    
    var payPalConfig = PayPalConfiguration()
    
    var environment: String = PayPalEnvironmentSandbox{
        willSet(newEnvironment){
            if(newEnvironment != environment){
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
    
    var acceptCreditCards: Bool = true{
        didSet{
            payPalConfig.acceptCreditCards = acceptCreditCards
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.dominoCheckoutPresenter.setCurrentAddressID()
        setupView()
        setupShipmentDetailsView()
        setupOrderSummaryView()
   
        setupPaymentMethodView(paymentType: .cc)
    }
    
    func setupView(){
      dominoCheckoutPresenter.attachView(view: self)
    }
    
    func updateShipmentAddressView(address:String){
        
       // self.shipmentDetailsUIView.shipmentOwnerAddressLabel.text = address
    }
    
    func setupShipmentDetailsView(){
        let containerSize = self.shipmentDetailsContainerView.bounds
        shipmentDetailsUIView = ShipmentDetailsUIView(frame: CGRect(x: 0, y: 0, width: containerSize.width, height: containerSize.height))
        self.shipmentDetailsContainerView.addSubview(shipmentDetailsUIView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.editShipmentDetails))
        shipmentDetailsUIView.addGestureRecognizer(tap)
        
        //self.dominoCheckoutPresenter.initializeShipmentDetails()
 
    
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        //self.dominoCheckoutPresenter.setCurrentAddressID()
        self.dominoCheckoutPresenter.setShipmentDetails(currentAddressID: self.currentAddressID ?? "")
    }
    
    @objc func editShipmentDetails(){
        print("tap address")
        self.dominoCheckoutPresenter.routeTo()
        //go to edit shipment details view controller
    }
    
    func setupOrderSummaryView(){
        let containerSize = self.orderSummaryContainerView.bounds
        orderSummaryUIView = OrderSummaryUIView(frame: CGRect(x: 0, y: 0, width: containerSize.width, height: containerSize.height))
        self.orderSummaryContainerView.addSubview(orderSummaryUIView)
        orderSummaryUIView.setupPrice(subTotal: subTotal, deliveryFee: deliveryFee, total: totalAmount)
    }
    
    func setupPaymentMethodView(paymentType: EnumPaymentType){
        let containerSize = self.paymentMethodContainerView.bounds
        paymentMethodUIView = PaymentMethodUIView(frame: CGRect(x:0, y:0, width: containerSize.width, height: containerSize.height))
        
        paymentMethodUIView.showPaymentView(paymentType: paymentType)
       // self.creditCardButton.isEnabled = false
       // self.codButton.isEnabled = true
        
        setupPayPal()
        
        self.paymentMethodContainerView.addSubview(paymentMethodUIView)

    }
    
    func setupPayPal(){
        payPalConfig.acceptCreditCards = acceptCreditCards;
        payPalConfig.merchantName = "gavin";
        payPalConfig.languageOrLocale = NSLocale.preferredLanguages[0]
        payPalConfig.payPalShippingAddressOption = .payPal

        
        PayPalMobile.preconnect(withEnvironment: environment)
        
    }
    

    
    @IBAction func payPalMethodButtonOnClick(_ sender: Any) {
        dominoCheckoutPresenter.payPalView()
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
            self.dominoCheckoutPresenter.removeAllCartItem()
            self.dominoCheckoutPresenter.resetAllView()
            
        }))
        self.present(alert,animated:true, completion:nil)
    }
    
    
    func resetAllView(){
 
//        switch screen{
//        case .pizzaHome:
//            self.performSegue(withIdentifier: screen.segueID(), sender: self)
//        }
        
        let mainViewController: UINavigationController = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "DominoHomeViewController") as! UINavigationController
        self.present(mainViewController, animated: false, completion: nil)

    }
    
    func routeTo(screen: DominoCheckoutEnumRoute){
        switch screen{
        case .pizzaManageShipmentDetails:
           
            self.performSegue(withIdentifier: screen.segueID(), sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.segue.dominoCheckoutViewController.checkoutToShipmentDetails.identifier{
            let shipmentDetailsVC = segue.destination as! DominoShipmentDetailsViewController
            shipmentDetailsVC.dominoCheckoutViewController = self
        }
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
    
    func setShipmentDetails(shipmentDetails: ShipmentDetailsViewData){
        self.shipmentDetails = shipmentDetails
        self.shipmentDetailsUIView.updateShipmentDetailsView(shipmentDetails: shipmentDetails)
    }
    
    func clearShipmentDetails(){
        self.shipmentDetailsUIView.clearShipmentDetailsView()
    }
    
    func showPayPalView(payment: PayPalPayment){
        let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
        present(paymentViewController!, animated: true, completion: nil)
    }
    
}

extension DominoCheckoutViewController: PayPalPaymentDelegate{
    
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        paymentViewController.dismiss(animated: true, completion: { () -> Void in
            
            print("\(completedPayment.amount,completedPayment.confirmation)\n\n")
            print("\(completedPayment.description)")
            
        })
        
        self.dominoCheckoutPresenter.removeAllCartItem()
        self.resetAllView()
    }
}
