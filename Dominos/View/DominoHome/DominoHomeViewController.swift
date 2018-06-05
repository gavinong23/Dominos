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
import DropDown

class DominoHomeViewController: BaseViewController {
    

    @IBOutlet weak var dropDownView: UIView!
    
    var refresher: UIRefreshControl!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var pizzaCollectionView: PizzaCollectionView!
    
    var toppings = [EnumPizzaToppings]()
    
    var dominoModels = [PizzasViewData]()
    
    private let dominoHomePresenter = DominoHomePresenter(pizzaService: PizzaService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup the main view
        setupView()
        
        //drag for reload data(refresher)
        setupRefresherView()
        
        //setup cart
        //setupCart()
        
        if !Reachability.isConnectedToNetwork(){
            noInternetConnectionRequest()
        }else{
            setupCollectionView()
        }

        self.refresher.addTarget(self, action: #selector(pullToRefreshCollectionView), for: .valueChanged)
        
    }
    
    func setupRefresherView(){
        self.refresher = UIRefreshControl()
        self.pizzaCollectionView.collectionView.alwaysBounceVertical = true
        self.pizzaCollectionView.collectionView.delegate = self
        self.pizzaCollectionView.collectionView.dataSource = self
        self.refresher.tintColor = UIColor.blue
        self.pizzaCollectionView.collectionView.addSubview(refresher)
    }
    
    func setupCollectionView(){
        self.dominoHomePresenter.getPizzas()
    }
    
    func noInternetConnectionRequest(){
        self.dominoHomePresenter.NoInternetConnectionGetPizza()
    }
    
    @objc func pullToRefreshCollectionView(){
        self.dominoHomePresenter.pullToRefreshGetPizza()
    }
    
    func setupView(){
        self.navigationItem.title = R.string.main.navigation_home_title()
        self.navigationItem.backBarButtonItem?.title = R.string.main.navigation_button_back()
        self.pickerView.isHidden = true
        self.pizzaCollectionView.collectionView.delegate = self
        self.pizzaCollectionView.collectionView.dataSource = self
        pickerView.delegate = self
        pickerView.dataSource = self
        dominoHomePresenter.attachView(view: self)
        
        //Register Nib
        self.pizzaCollectionView.collectionView.register(R.nib.dominoPizzaHomeCollectionViewCell)
    }
    
    func setupCart(){
       // self.dominoHomePresenter.setupCart()
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension DominoHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       self.pizzaCollectionView.collectionView.animateVisibleCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? DominoPizzaHomeCollectionViewCell {
           self.pizzaCollectionView.collectionView.animateCell(cell)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dominoModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let dominoModel: PizzasViewData
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.dominoPizzaHomeCollectionViewCell, for: indexPath) as! DominoPizzaHomeCollectionViewCell
        
        self.pizzaCollectionView.collectionView.drawShadow(cell: cell)
        
        dominoModel = self.dominoModels[indexPath.row]
        
        self.toppings = dominoModel.pizzaToppingImage!
        
        cell.populateCell(pizza: dominoModel, cell: cell)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = dominoModels[indexPath.row]
        self.dominoHomePresenter.getPizzaDetail(model: model)
    }
}


extension DominoHomeViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return EnumPizzaToppings.allValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        
        
        return self.dominoHomePresenter.bindToppingToPicker(row: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
     
        print(EnumPizzaToppings.allValues[row])
        self.dominoHomePresenter.sortPizza(selectedTopping: EnumPizzaToppings.allValues[row])
    }
    
    
}

extension DominoHomeViewController: DominoPizzaHomeViewType{
    
    func setPizzas(pizzas:[PizzasViewData]){
        self.dominoModels = pizzas
        self.pickerView.isHidden = true
        self.pizzaCollectionView.setEmptyPizza(pizzaCount:pizzas.count)
       
    
    }
    
    func showPickerView(){
        self.pickerView.isHidden = false
    }
    
    func filterPizza(pizzas: [PizzasViewData]){
        self.dominoModels = pizzas
        self.pizzaCollectionView.setEmptyPizza(pizzaCount:pizzas.count)
    }
    
    func noConnection(errorMessage:String, isConnectedToNetwork: Bool){
        self.pizzaCollectionView.noConnection(errorMessage: errorMessage, isConnectedToNetwork: isConnectedToNetwork)
        self.pickerView.isHidden = true
    }
    
    
    func stopRefresher() {
        self.refresher.endRefreshing()
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



