//
//  ViewController.swift
//  Dominos
//
//  Created by OngBoonFong on 26/04/2018.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import UIKit

class DominoPizzaHomeDetailViewController: UIViewController {
    

    //var dominoModels = [PizzasViewData]()
    //var dominoPizzaObj:PizzasViewData? = nil
    
    private let dominoDetailPresenter = DominoPizzaDetailPrenseter(pizzaService: PizzaService())
    
    var pizzaID: String?

    @IBOutlet weak var emptyView: UIView!
    
    @IBOutlet weak var dominoPizzaFullImageView: UIImageView!
    
    @IBOutlet weak var dominoPizzaNameLabel: UILabel!
    
    @IBOutlet weak var dominoPizzaDescLabel: UILabel!
    
    @IBOutlet weak var dominoPizzaTypeStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupStackView()
    }
    
    func setupView(){
        self.navigationItem.title = R.string.main.navigation_homedetail_title()
        dominoDetailPresenter.attachView(view: self)
        self.dominoDetailPresenter.getPizzaDetail()
    }
    

    func setupStackView(){
        
        print("DetailGetPizzaID:\(pizzaID)")
//        if let dominoPizzaObj = self.dominoPizzaObj{
//            //dominoPizzaFullImageView.kf.setImage(with: dominoPizzaObj.pizzaFull)
//            dominoPizzaNameLabel.text = dominoPizzaObj.pizzaName
//            dominoPizzaDescLabel.text = dominoPizzaObj.pizzaDesc
//
//            let pizzaToppingIcons = dominoPizzaObj.pizzaToppingImage
//
//            if let pizzaToppingIcons = pizzaToppingIcons{
//                pizzaToppingIcons.map{ pizzaToppingIcon in
//                    let imageView = UIImageView()
//                    imageView.kf.setImage(with: pizzaToppingIcon)
//                    imageView.frame = CGRect(x:0, y:0, width: 32, height: 32)
//                    imageView.layer.borderWidth = 1.0
//                    imageView.layer.masksToBounds = false
//                    imageView.clipsToBounds = true
//
//                    imageView.layer.cornerRadius = imageView.frame.size.height/2
//
//                    dominoPizzaTypeStackView.addArrangedSubview(imageView)
//                }
//            }
//        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension DominoPizzaHomeDetailViewController: DominoPizzaDetailViewType{
    
 
    func setPizzaDetail(pizza:PizzaDetailViewData){
        self.dominoPizzaFullImageView.kf.setImage(with: pizza.pizzaFullImage)
        self.dominoPizzaNameLabel.text = pizza.pizzaName
        self.dominoPizzaDescLabel.text = pizza.pizzaDesc
    }
    
    
    func getPizzaID() -> String{
        return self.pizzaID ?? ""
    }
    
    func setEmptyPizzaDetail() {
        self.emptyView.isHidden = false
    }
    
    func startLoading(){
        self.presentLoadingView()
    }
    
    func stopLoading(){
        self.dismissLoadingView()
    }
    
}

//for i in dominoPizzaObj.pizzaTypeImg!{
//    let image = UIImage(named: i)
//    let imageView = UIImageView(image : image)
//    imageView.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
//    imageView.layer.borderWidth=1.0
//    imageView.layer.cornerRadius = imageView.frame.size.height/2
//    dominoPizzaTypeStackView.addArrangedSubview(imageView)
//}

