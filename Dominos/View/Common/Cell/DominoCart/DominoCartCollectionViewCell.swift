//
//  DominoCartCollectionViewCell.swift
//  Dominos
//
//  Created by Gavin Ong on 30/5/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import UIKit



class DominoCartCollectionViewCell: UICollectionViewCell {


    
    @IBOutlet weak var pizzaNameLabel: UILabel!
    
    
    @IBOutlet weak var pizzaThumbnail: UIImageView!
    
    
    @IBOutlet weak var pizzaIconStackView: UIStackView!
    
    @IBOutlet weak var pizzaPriceLabel: UILabel!
    
    @IBOutlet weak var pizzaQuantityStackView: UIStackView!
    
    
  
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var stepper: UIStepper!
    
    @IBOutlet weak var wishListIcon: UIImageView!
    
    
    @IBOutlet weak var removeIcon: UIImageView!
    
    
    var pizza: PizzaDetailViewData?
    
    
    let quantity = ["1","2","3","4","5"]
    
    var totalPriceLabel = UILabel()
    
    var didUpdateQuantity: ((_ quantityValue: Double) -> Void)?
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        setupStepperView()
    }
    
    func populateCell(pizza: PizzaDetailViewData, cell: DominoCartCollectionViewCell){
//        setupPickerView()
         pizzaNameLabel.text = pizza.pizzaName
        
         let pizzaToppingIcons = pizza.pizzaToppingImage
        
        let subviews = cell.pizzaIconStackView.arrangedSubviews
        
        subviews.map{ subview in
            subview.removeFromSuperview()
        }
        
        if let pizzaToppingIcons = pizzaToppingIcons{
            pizzaToppingIcons.map{ pizzaToppingIcon in
                let imageView = UIImageView()
                imageView.image = pizzaToppingIcon.toppingImage()
                imageView.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
                imageView.layer.borderWidth=1.0
                imageView.layer.masksToBounds = false
                imageView.clipsToBounds = true
                imageView.layer.cornerRadius = imageView.frame.size.height/2
                pizzaIconStackView.addArrangedSubview(imageView)
            }
        }
        
        quantityLabel.text = "1"
        
       // self.totalPriceLabel = totalPriceLabel
        
//        totalPriceLabel.text = String(format:"Total: RM %.2f",pizza.pizzaPrice ?? 0.0)
        
        self.pizza = pizza
        
        pizzaPriceLabel.text = String(format:"RM %.2f",pizza.pizzaPrice ?? 0.0)
//        "RM \(pizza.pizzaPrice ?? 0.00)"
        
        
        pizzaThumbnail.kf.setImage(with: pizza.pizzaThumbnail)
        
    
    }
    
    func setupStepperView(){
       // stepper.isContinuous = false
        
    }
    
    
    @IBAction func stepperOnClick(_ sender: UIStepper) {
        
        didUpdateQuantity?(sender.value)
        
        quantityLabel.text = String(Int(sender.value + 1))
        
        //totalPriceLabel.text = String(format:"Total : RM %.2f",Float(sender.value+1) * (pizza?.pizzaPrice)!)
        
    }
    
}



