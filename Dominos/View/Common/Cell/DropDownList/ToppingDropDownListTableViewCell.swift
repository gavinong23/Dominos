//
//  ToppingDropDownListTableViewCell.swift
//  Dominos
//
//  Created by Gavin Ong on 24/5/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import UIKit
import DropDown

class ToppingDropDownListTableViewCell: DropDownCell {

    @IBOutlet weak var toppingDropDownLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


