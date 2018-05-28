//
//  DominoPizzaCollectionViewCell.swift
//  Dominos
//
//  Created by OngBoonFong on 26/04/2018.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import UIKit
import Gemini


class DominoPizzaHomeCollectionViewCell: GeminiCell {
    
 
    @IBOutlet weak var pizzaNameLabel: UILabel!
    
    @IBOutlet weak var dominoPizzaTypeStackView: UIStackView!
        
    @IBOutlet weak var pizzaThumnail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func populateCell(pizza : PizzasViewData, cell: DominoPizzaHomeCollectionViewCell){
        pizzaNameLabel.text = pizza.pizzaName
        
        let imageIcon = UIImage(named: "icon-image")
        pizzaThumnail.kf.setImage(with: pizza.pizzaThumbnail, progressBlock:{
            receivedSize, totalSize in
            let percentage = (Float(receivedSize) / Float(totalSize)) * 100.0
            print("downloading progress: \(percentage)%")
            //myIndicator.percentage = percentage
        })

        
        let pizzaToppingIcons = pizza.pizzaToppingImage
        
        let subviews = cell.dominoPizzaTypeStackView.arrangedSubviews
        
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
                dominoPizzaTypeStackView.addArrangedSubview(imageView)
            }
        }
        
    }

}
