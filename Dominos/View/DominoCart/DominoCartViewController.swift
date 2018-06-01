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
    
    private let dominoCartPresenter = DominoCartPresenter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupCartCollectionView()
        
        //print("ggwp:\(dominoModels)")
        
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        dominoCartPresenter.setCart(items: dominoModels)
        dominoCartPresenter.attachView(view: self)
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
    

}

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
    
        self.collectionView.drawShadow(cell: cell)
        
        var totalPrice: Float = 0.0
    
//        if let pizzaPrice = dominoModel.pizzaPrice{
////            print(pizzaPrice)
//            totalPrice += pizzaPrice
////            print(totalPrice)
//        }
        
        
        self.totalPriceLabel.text =  String(format:"Total : RM %.2f",totalPrice)
        
        cell.didUpdateQuantity = { (quantityValue) in
            print(quantityValue)
            
            if var pizzaQuantity = dominoModel.pizzaQuantity{
                pizzaQuantity += quantityValue
                
                
            }
            
            self.dominoCartPresenter.calculateGrandTotal(item: dominoModel)
            
//            self.totalPriceLabel.text = String(format:"Total : RM %.2f",Float(quantityValue+1) * dominoModel.pizzaPrice!)
        }
    
        cell.populateCell(pizza: dominoModel, cell: cell)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let model = dominoModels[indexPath.row]
//        self.dominoHomePresenter.getPizzaDetail(model: model)
    }
    
}

extension DominoCartViewController: DominoCartViewType{
    
    
    func updateGrandTotal(grandTotal: Float){
        self.totalPriceLabel.text = String(format:"Total : RM %.2f",grandTotal)
    }
    
    
}
