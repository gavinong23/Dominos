//
//  ManageAddressUIView.swift
//  Dominos
//
//  Created by Gavin Ong on 12/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ManageAddressUIView: UIView{

    

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var addNewAddressView: UIView!
    
    @IBOutlet weak var chooseAddressView: UIView!
    
    @IBOutlet weak var mapView: UIView!

    @IBOutlet weak var confirmAddressButton: UIButton!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var addNewAddressButton: UIButton!
    
    @IBOutlet weak var addressTableView: UITableView!
    
    @IBOutlet weak var addressResultTableView: UITableView!
    //    var dominoShipmentDetailsViewController: DominoShipmentDetailsViewController!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView(){
        Bundle.main.loadNibNamed(R.nib.manageAddressUIView.name, owner: self, options: nil)
        
        self.addNewAddressView.isHidden = true
        self.chooseAddressView.isHidden = false
//        self.addressTableView.isHidden = true
        self.mapView.isHidden = false
        
        
//        self.bringSubview(toFront: self.mapView)

        //test
//        self.addNewAddressView.isHidden = false
//        self.chooseAddressView.isHidden = true
        
        
        //test
//            self.addressTableView.isHidden = false
//            self.addNewAddressView.isHidden = true
//            self.chooseAddressView.isHidden = true
     
        
        self.addressResultTableView.transform = CGAffineTransform(rotationAngle: -(CGFloat)(Float.pi))
        
        addSubview(contentView)
        
        contentView.frame = self.bounds
        
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
//        setupAddressAutoCompleteTableView()
    }
    
    func hideAutoCompletionTableView(){
//        self.addressTableView.isHidden = true
//        self.chooisHidden = true
        self.chooseAddressView.isHidden = true
        self.addressResultTableView.isHidden = true
        self.mapView.isHidden = false
//        self.bringSubview(toFront: self.mapView)
    }
    
    func showAutoCompletionTableView(){
//        self.addNewAddressView.isHidden = false
        self.addressResultTableView.isHidden = false
        self.chooseAddressView.isHidden = true
        self.mapView.isHidden = true
//        self.bringSubview(toFront: self.addressTableView)
    }
    
    func addressAutoCompleteReloadData(){
       self.addressResultTableView.reloadData()
    }
    
    @IBAction func addNewAddressOnClick(_ sender: Any) {
        self.addNewAddressView.isHidden = false
        self.chooseAddressView.isHidden = true
        self.mapView.isHidden = false
        
    }
    
    func addAddressButton(isEnabled:Bool){
        addNewAddressButton.isEnabled = isEnabled
    }
    
//    func setupPrice(subTotal:String, deliveryFee:String, total:String){
////        self.subTotalLabel.text = subTotal
////        self.shippingFeeLabel.text = deliveryFee
////        self.totalAmountLabel.text = total
//    }

}




