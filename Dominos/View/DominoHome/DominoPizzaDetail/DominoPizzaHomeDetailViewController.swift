//
//  ViewController.swift
//  Dominos
//
//  Created by OngBoonFong on 26/04/2018.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import UIKit

class DominoPizzaHomeDetailViewController: BaseViewController {
    
    var pizzaID: String?
    
    private let dominoDetailPresenter = DominoPizzaDetailPrenseter(pizzaService: PizzaService())

    @IBOutlet weak var emptyView: UIView!
    
    @IBOutlet weak var dominoPizzaFullImageView: UIImageView!
    
    @IBOutlet weak var dominoPizzaNameLabel: UILabel!
    
    @IBOutlet weak var dominoPizzaDescLabel: UILabel!
    
    @IBOutlet weak var dominoPizzaTypeStackView: UIStackView!
    
    @IBOutlet weak var imageProgressBar: UIProgressView!
    
     var model = PizzaDetailViewData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupStackView()
    }
    
    func setupView(){
        self.navigationItem.title = R.string.main.navigation_homedetail_title()
        dominoDetailPresenter.attachView(view: self)
        self.imageProgressBar.isHidden = true
        self.dominoDetailPresenter.getPizzaDetail()

    }
    
    func setupStackView(){
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    

    
    @IBAction func addToCartButtonOnClick(_ sender: Any) {
        self.dominoDetailPresenter.getAddToCart(model: model)
        
    }
    
    
    
}

extension DominoPizzaHomeDetailViewController: DominoPizzaDetailViewType{
    
 
    func setPizzaDetail(pizza:PizzaDetailViewData){
        
        self.dominoPizzaFullImageView.kf.setImage(with: pizza.pizzaFullImage, progressBlock:{
            receivedSize, totalSize in
            let percentage = (Float(receivedSize) / Float(totalSize))
            
            if percentage != 0{
                self.imageProgressBar.isHidden = false
                print("downloading progress: \(percentage)%")
                self.imageProgressBar.setProgress(percentage, animated: true)
                
                if percentage == 1{
                    self.imageProgressBar.isHidden = true
                }
            }
            
        })
        
        self.dominoPizzaNameLabel.text = pizza.pizzaName
        self.dominoPizzaDescLabel.text = pizza.pizzaDesc
        
         let pizzaToppingIcons = pizza.pizzaToppingImage
        
        if let pizzaToppingIcons = pizzaToppingIcons{
            pizzaToppingIcons.map{ pizzaToppingIcon in
                let imageView = UIImageView()
                imageView.image = pizzaToppingIcon.toppingImage()
                imageView.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
                imageView.layer.borderWidth=1.0
                imageView.layer.masksToBounds = false
                imageView.clipsToBounds = true
                imageView.layer.cornerRadius = imageView.frame.size.height/2
                dominoPizzaTypeStackView.addArrangedSubview(imageView)
            }
        }
        self.model = pizza
    }
    
    func getPizzaID() -> String{
        return self.pizzaID ?? ""
    }
    
    func setEmptyPizzaDetail(errorMessage:String) {
        self.addErrorView(errorMessage: errorMessage)
    }
    
    func startLoading(){
        self.presentLoadingView()
    }
    
    func stopLoading(){
        self.dismissLoadingView()
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//                let dominoModel: PizzaDetailViewData
        
        
        if(segue.identifier == R.segue.dominoPizzaHomeDetailViewController.pizzaDetailToPizzaCartID.identifier){
            
            
            if let dominoModel = sender as? PizzaDetailViewData{
                let DominoCartViewController = segue.destination as! DominoCartViewController
                DominoCartViewController.dominoModels.append(dominoModel)
            }
            
            
        }
    }
    
    func routeTo(screen:EnumDominoDetailRoute){
        
        switch screen{
            case .pizzaCart(let model):
            
                self.performSegue(withIdentifier: screen.segueID(), sender: model)
            }
        
    }
    
}

