//
//  DominoCartCollectionViewCell.swift
//  Dominos
//
//  Created by Gavin Ong on 30/5/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import UIKit

class DominoCartCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var pizzaThumbnail: UIImageView!
    
    @IBOutlet weak var pizzaNameLabel: UILabel!
    
    
    @IBOutlet weak var pizzaIconStackView: UIStackView!
    
    
    @IBOutlet weak var pizzaPriceLabel: UILabel!
    
    @IBOutlet weak var quantityPickerView: UIPickerView!
    
    
    @IBOutlet weak var wishListImageView: UIImageView!
    
    @IBOutlet weak var RemovePizzaImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
