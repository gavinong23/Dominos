//
//  DominoCartViewController.swift
//  Dominos
//
//  Created by Gavin Ong on 30/5/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import UIKit

class DominoCartViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dominoModels = [PizzaDetailViewData]()
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var subTotalLabel: UILabel!
    
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    
    @IBOutlet weak var checkoutButton: UIButton!
    
    private let dominoCartPresenter = DominoCartPresenter(cartService: CartService(),pizzaService: PizzaService())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupCartCollectionView()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func checkOutButtonOnClick(_ sender: Any) {
        
       self.dominoCartPresenter.routeToCheckout()
        //self.performSegue(withIdentifier: R.segue.dominoCartViewController.dominoCartToCheckOutID, sender: sender)
    }
    
    func setupView(){
        dominoCartPresenter.attachView(view: self)
        dominoCartPresenter.setCart()
    }
    
    func setupCartCollectionView(){
        
        //Register Nib
        self.collectionView.register(R.nib.dominoCartCollectionViewCell)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func clearAllBarButtonOnClick(_ sender: Any) {
        dominoCartPresenter.removeAllCartItem()
    }
    
    
}

//Clear all cart item


extension DominoCartViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return dominoModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var dominoModel: PizzaDetailViewData
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.dominoCartCollectionViewCell, for: indexPath) as! DominoCartCollectionViewCell
    
        dominoModel = self.dominoModels[indexPath.row]
        
        cell.removeCartItemButton.tag = Int(dominoModel.pizzaID!)!
        
        cell.removeCartItemButton.addTarget(self, action: #selector(self.removeButtonOnClick), for: UIControlEvents.touchUpInside)
    
        self.collectionView.drawShadow(cell: cell)
        
        cell.didUpdateQuantity = { (quantityValue) in

                dominoModel.pizzaQuantity = dominoModel.pizzaQuantity! + quantityValue
            
            self.dominoCartPresenter.subTotalWithUpdateQuantity(item: dominoModel)
        }
    
        cell.populateCell(pizza: dominoModel, cell: cell)
        
        return cell
    }
    
    @objc func removeButtonOnClick(sender: UIButton){

        self.dominoCartPresenter.removeParticularCartItem(pizzaID:sender.tag)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let model = dominoModels[indexPath.row]
//        self.dominoHomePresenter.getPizzaDetail(model: model)
    }
    
}

extension DominoCartViewController: DominoCartViewType{
    
    func setCart(dominoModels: [PizzaDetailViewData], subTotal: Float,grandTotal: Float){
        self.dominoModels.removeAll()
        self.dominoModels = dominoModels
        self.subTotalLabel.text = String(format:"RM %.2f",subTotal)
        self.totalPriceLabel.text =  String(format:"RM %.2f",grandTotal)
        self.collectionView.reloadData()
    }
    
    func updateSubTotal(dominoModels: [PizzaDetailViewData], grandTotal: Float){
        self.dominoModels.removeAll()
        self.dominoModels = dominoModels
        self.subTotalLabel.text = String(format:"RM %.2f",grandTotal)
    }
    
    func removeParticularCartItem(dominoModels: [PizzaDetailViewData]){
        self.dominoModels.removeAll()
        self.dominoModels = dominoModels
        self.collectionView.reloadData()
    }
    
    func removeAllCartItem(){
        self.dominoModels.removeAll()
        self.collectionView.reloadData()
    }
    
    func setDeliveryFee(deliveryFee:Float){
        self.deliveryFeeLabel.text = String(format:"RM %.2f",deliveryFee)
    }
    
    func showAlertBox(title:String,message:String){
        let alert = UIAlertController(title: title , message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func routeTo(screen:EnumDominoCartRoute){
        
        switch screen{
            case .checkout:
                self.performSegue(withIdentifier: screen.segueID(), sender: self)
            }
        
    }
    
    func disableCheckoutButton(){
        self.checkoutButton.isEnabled = false

    }
    
    func enableCheckoutButton(){
        self.checkoutButton.isEnabled = true
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == R.segue.dominoCartViewController.dominoCartToCheckOutID.identifier){
            
            //dominoModel = (sender as? PizzasViewData)!
            
            let DominoCheckoutViewController = segue.destination as! DominoCheckoutViewController
            
            DominoCheckoutViewController.subTotal = self.subTotalLabel.text!
            DominoCheckoutViewController.deliveryFee = self.deliveryFeeLabel.text!
            DominoCheckoutViewController.totalAmount = self.totalPriceLabel.text!
        }
    }
    
    
}
