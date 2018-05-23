//
//  ViewController.swift
//  Dominos
//
//  Created by OngBoonFong on 26/04/2018.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import UIKit
import Gemini
import NVActivityIndicatorView
import Kingfisher

class DominoHomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: GeminiCollectionView!
    
    @IBOutlet weak var emptyPizzaView: UIView!
    
    var dominoModels = [PizzasViewData]()
    var dominoModel = [DominoListingModel]()
    private let dominoHomePresenter = DominoHomePresenter(pizzaService: PizzaService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
    }
    
    
    func setupView(){
        self.navigationItem.title = R.string.main.navigation_home_title()
        self.navigationItem.backBarButtonItem?.title = R.string.main.navigation_button_back()
        collectionView.delegate = self
        collectionView.dataSource = self
        dominoHomePresenter.attachView(view: self)
        
        
        //Register Nib
        self.collectionView.register(R.nib.dominoPizzaHomeCollectionViewCell)
    
    }
    
    func setupCollectionView(){
        self.dominoHomePresenter.getPizzas()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension DominoHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.collectionView.animateVisibleCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? DominoPizzaHomeCollectionViewCell {
            self.collectionView.animateCell(cell)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dominoModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let dominoModel: PizzasViewData
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.dominoPizzaHomeCollectionViewCell, for: indexPath) as! DominoPizzaHomeCollectionViewCell
        
        self.collectionView.drawShadow(cell: cell)
        
        dominoModel = self.dominoModels[indexPath.row]
        
        cell.populateCell(pizza: dominoModel, cell: cell)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = dominoModels[indexPath.row]
        self.dominoHomePresenter.getPizzaDetail(model: model)
    }
    

}

extension DominoHomeViewController: DominoPizzaHomeViewType{
    
    func setPizzas(pizzas:[PizzasViewData]){
        self.dominoModels = pizzas
        self.collectionView.isHidden = false
        self.emptyPizzaView.isHidden = true
        self.collectionView.reloadData()
    }
    
    func setEmptyPizza() {
        self.collectionView.isHidden = true
        self.emptyPizzaView.isHidden = false
    }
    
    func startLoading(){
        self.presentLoadingView()
    }
    
    func stopLoading(){
        self.dismissLoadingView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dominoModel: PizzasViewData
        
        if(segue.identifier == R.segue.dominoHomeViewController.pizzaHomeToPizzaHomeDetailID.identifier){
            
            dominoModel = (sender as? PizzasViewData)!
           
            let DominoPizzaHomeDetailViewController = segue.destination as! DominoPizzaHomeDetailViewController
        
            //DominoPizzaHomeDetailViewController.dominoPizzaObj = dominoModel
            DominoPizzaHomeDetailViewController.pizzaID = dominoModel.pizzaID
        }
    }
    
    func routeTo(screen:EnumDominoHomeRoute){
//        let a = ["a", "d", "c"]
//        let b = a.filter{ pizza.price > 15 }
//        if b.count == 0 {
//            label.text = "no items above RM 15"
//        }
        
        switch screen{
            case .pizzaDetail(let model):
//                if (model.pizzaToppingImage?.contains(.shrimp))!{
//                    self.performSegue(withIdentifier: "new screen", sender: model)
//                } else {
//                    self.performSegue(withIdentifier: screen.segueID(), sender: model)
//                }
                self.performSegue(withIdentifier: screen.segueID(), sender: model)
        }
    }
    
}



