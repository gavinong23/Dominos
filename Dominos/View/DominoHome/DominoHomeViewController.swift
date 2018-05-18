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
    var dominoModel = [DominoModel]()
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
        
        cell.pizzaThumnail.kf.setImage(with:dominoModel.pizzaThumbnail)

        cell.pizzaNameLabel.text = dominoModel.pizzaName
        
        let subviews = cell.dominoPizzaTypeStackView.arrangedSubviews
        
        subviews.map{ subview in
            subview.removeFromSuperview()
        }
        
        let pizzaToppingIcons = dominoModel.pizzaToppingImage

        if let pizzaToppingIcons = pizzaToppingIcons{
            pizzaToppingIcons.map{ pizzaToppingIcon in
                    let imageView = UIImageView()
                    imageView.kf.setImage(with: pizzaToppingIcon)
                    imageView.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
                    imageView.layer.borderWidth=1.0
                    imageView.layer.masksToBounds = false
                    imageView.clipsToBounds = true
                    imageView.layer.cornerRadius = imageView.frame.size.height/2
                    cell.dominoPizzaTypeStackView.addArrangedSubview(imageView)
            }
         }
        
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
        
            DominoPizzaHomeDetailViewController.dominoPizzaObj = dominoModel
        }
    }
    
    func routeTo(screen:EnumDominoHomeRoute){
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



