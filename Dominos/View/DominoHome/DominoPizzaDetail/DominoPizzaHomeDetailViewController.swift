//
//  ViewController.swift
//  Dominos
//
//  Created by OngBoonFong on 26/04/2018.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import UIKit

class DominoPizzaHomeDetailViewController: UIViewController {
    

    var dominoModels = [PizzasViewData]()
    var dominoPizzaObj:PizzasViewData? = nil
    
    
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
    }
    
    func setupStackView(){
        if let dominoPizzaObj = self.dominoPizzaObj{
            //dominoPizzaFullImageView.image = dominoPizzaObj.pizzaImage![1]
            //dominoPizzaFullImageView.image = dominoPizzaObj.pizzaImage![1].pizzaImage()
            dominoPizzaNameLabel.text = dominoPizzaObj.pizzaName
            dominoPizzaDescLabel.text = dominoPizzaObj.pizzaDesc
            
//            let pizzaTypeIcons = dominoPizzaObj.pizzaToppingImage!
//
//            pizzaTypeIcons.map{ pizzaTypeIcon in
//
//                switch pizzaTypeIcon {
//
//                case .shrimp:
//                    dominoPizzaDescLabel.text?.append("\n\n*this contain seafood")
//                    default:
//                        return
//
//                }
//
//                let image = pizzaTypeIcon.toppingImage()
//                let imageView = UIImageView(image : image)
//                imageView.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
//                imageView.layer.borderWidth=1.0
//                imageView.layer.masksToBounds = false
//                imageView.clipsToBounds = true
//
//                imageView.layer.cornerRadius = imageView.frame.size.height/2
//
//                dominoPizzaTypeStackView.addArrangedSubview(imageView)
//            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

