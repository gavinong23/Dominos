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
    
    @IBOutlet weak var emptyViewLabel: UILabel!
     var refresher: UIRefreshControl!
    
    var dominoModels = [PizzasViewData]()
    
    private let dominoHomePresenter = DominoHomePresenter(pizzaService: PizzaService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        //setupCollectionView()
        
        //refresh()
        
        if !Reachability.isConnectedToNetwork(){
            refreshCollectionView()
        }else{
            setupCollectionView()
        }
        
        self.refresher.addTarget(self, action: #selector(pullToRefreshCollectionView), for: .valueChanged)
        
    }
    
    func setupCollectionView(){
        self.dominoHomePresenter.getPizzas()
    }
    
    func refreshCollectionView(){
        self.dominoHomePresenter.NoInternetConnectionGetPizza()
    }
    
    @objc func pullToRefreshCollectionView(){
        self.dominoHomePresenter.pullToRefreshGetPizza()
    }

    func setupView(){
        self.navigationItem.title = R.string.main.navigation_home_title()
        self.navigationItem.backBarButtonItem?.title = R.string.main.navigation_button_back()
        collectionView.delegate = self
        collectionView.dataSource = self
        dominoHomePresenter.attachView(view: self)
        self.refresher = UIRefreshControl()
        self.collectionView!.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.red
        self.collectionView!.addSubview(refresher)
    
        //Register Nib
        self.collectionView.register(R.nib.dominoPizzaHomeCollectionViewCell)
    
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
    
    func setEmptyPizza(isConnectedToNetwork:Bool) {
        
        if !isConnectedToNetwork{
            self.emptyViewLabel.text = "No Internet Connection. Please connect to the Internet and wait for awhile for the app to refresh."
        }else{
            self.emptyViewLabel.text = "No pizza added."
        }
        
        self.collectionView.isHidden = true
        self.emptyPizzaView.isHidden = false
        
    
   
    }
    
    func stopRefresher() {
        self.refresher.endRefreshing()
    }
    
    func startLoading(){
        self.presentLoadingView()
    }
    
    func startEmptyViewLoading(){
    
        
    }
    
    func stopLoading(){
        self.dismissLoadingView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dominoModel: PizzasViewData
        
        if(segue.identifier == R.segue.dominoHomeViewController.pizzaHomeToPizzaHomeDetailID.identifier){
            
            dominoModel = (sender as? PizzasViewData)!
           
            let DominoPizzaHomeDetailViewController = segue.destination as! DominoPizzaHomeDetailViewController
        
            DominoPizzaHomeDetailViewController.pizzaID = dominoModel.pizzaID
        }
    }
    
    func routeTo(screen:EnumDominoHomeRoute){

        
        switch screen{
            case .pizzaDetail(let model):
                
                self.performSegue(withIdentifier: screen.segueID(), sender: model)
        }
    }
    
}



