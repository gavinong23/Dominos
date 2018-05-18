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
        // Initialization code
    }

}
