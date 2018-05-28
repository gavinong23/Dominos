//
//  emptyPizzaView.swift
//  Dominos
//
//  Created by Gavin Ong on 28/5/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import UIKit

class emptyPizzaView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var emptyPizzaLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed(R.nib.emptyPizzaView.name, owner: self, options : nil)
        
        addSubview(contentView)
        
        contentView.frame = self.bounds
        
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }


}
