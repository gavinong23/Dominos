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
    
    func updateShipmentDetailsView(shipmentDetails: ShipmentDetailsViewData){
    
        self.shipmentOwnerAddressLabel.text = String(format:"Address: %@",shipmentDetails.address!)
        self.shipmentOwnerContactNumberLabel.text = String(format:"Contact Number: %@ ",shipmentDetails.contactNumber!)
        self.shipmentOwnerNameLabel.text = shipmentDetails.userName
    }
    
    func clearShipmentDetailsView(){
        self.shipmentOwnerAddressLabel.text = "Address: "
        self.shipmentOwnerContactNumberLabel.text = "Contact Number: "
        self.shipmentOwnerNameLabel.text = ""
    }

    
  
}
