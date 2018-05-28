//
//  emptyPizzaView.swift
//  Dominos
//
//  Created by Gavin Ong on 28/5/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import UIKit
import Gemini

class PizzaCollectionView: UIView{

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var emptyPizzaLabel: UILabel!
    @IBOutlet weak var collectionView: GeminiCollectionView!
    @IBOutlet weak var noInternetConnectionView: UIView!
    @IBOutlet weak var noInternetLabel: UILabel!
    @IBOutlet weak var emptyPizzaView: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView(){
        Bundle.main.loadNibNamed(R.nib.pizzaCollectionView.name, owner: self, options : nil)
        addSubview(contentView)
        
        contentView.frame = self.bounds
        
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    
    func setEmptyConnectionPizza(errorMessage: String,isConnectedToNetwork:Bool) {
            if !isConnectedToNetwork{
                self.noInternetConnectionView.isHidden = false
                self.emptyPizzaView.isHidden = true
                self.collectionView.isHidden = true
                self.noInternetLabel.text = errorMessage
            }
        
        //self.pickerView.isHidden = true
    }
    
    func setEmptyPizza(pizzaCount : Int){
        if pizzaCount == 0{
            self.emptyPizzaView.isHidden = false
            self.collectionView.isHidden = false
            self.noInternetConnectionView.isHidden = true
        }else{
            self.collectionView.isHidden = false
            self.emptyPizzaView.isHidden = true
            self.noInternetConnectionView.isHidden = true
        }
    }
    
}




