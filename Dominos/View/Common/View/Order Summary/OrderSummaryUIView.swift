//
//  OrderSummaryUIView.swift
//  Dominos
//
//  Created by Gavin Ong on 8/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import UIKit

class OrderSummaryUIView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var subTotalLabel: UILabel!
    
    @IBOutlet weak var shippingFeeLabel: UILabel!
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView(){
        
        Bundle.main.loadNibNamed(R.nib.orderSummaryUIView.name, owner: self, options: nil)
        
        addSubview(contentView)
        
        contentView.frame = self.bounds
        
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func setupPrice(subTotal:String, deliveryFee:String, total:String){
        self.subTotalLabel.text = subTotal
        self.shippingFeeLabel.text = deliveryFee
        self.totalAmountLabel.text = total
    }
    

}
