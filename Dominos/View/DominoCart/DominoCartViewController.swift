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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupCartCollectionView()
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        
    }
    
    func setupCartCollectionView(){
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
//        return self.dominoModels.count
        return dominoModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let dominoModel: PizzasViewData
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.dominoPizzaHomeCollectionViewCell, for: indexPath) as! DominoPizzaHomeCollectionViewCell
        
//        self.pizzaCollectionView.collectionView.drawShadow(cell: cell)
//
//        dominoModel = self.dominoModels[indexPath.row]
//
//        self.toppings = dominoModel.pizzaToppingImage!
//
//        cell.populateCell(pizza: dominoModel, cell: cell)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let model = dominoModels[indexPath.row]
//        self.dominoHomePresenter.getPizzaDetail(model: model)
    }
    
}
