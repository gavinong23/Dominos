//
//  OrderSummaryUIView.swift
//  Dominos
//
//  Created by Gavin Ong on 8/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import UIKit

class ShipmentDetailsUIView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var shipmentOwnerNameLabel: UILabel!
    
    @IBOutlet weak var shipmentOwnerAddressLabel: UILabel!
    
    @IBOutlet weak var shipmentOwnerContactNumberLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
 
        
    private func setupView(){
      
        Bundle.main.loadNibNamed(R.nib.shipmentDetailsUIView.name, owner: self, options: nil)
        
        addSubview(contentView)

        contentView.frame = self.bounds

        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    

    
  
}
