//
//  ShipmentDetailsViewController.swift
//  Dominos
//
//  Created by Gavin Ong on 12/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

class DominoShipmentDetailsViewController: UIViewController {
    
    var manageAddressUIView = ManageAddressUIView()
    
    private let dominoShipmentPresenter = DominoShipmentPresenter(locationService:LocationService())
    
    @IBOutlet weak var manageAddressContainerView: UIView!
    
    var arrayAddress = [GMSAutocompletePrediction]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupManageAddressView()
        manageAddressUIView.addAddressButton(isEnabled: true)
        
    }
    
    
    func setupView(){
        dominoShipmentPresenter.attachView(view: self)
        
    }
    
    func setupManageAddressView(){
        let containerSize = self.manageAddressContainerView.bounds
        manageAddressUIView = ManageAddressUIView(frame: CGRect(x: 0, y: 0, width: containerSize.width, height: containerSize.height))
        self.manageAddressContainerView.addSubview(manageAddressUIView)
        setupAutoCompleteAddressTableView()
        
        self.manageAddressUIView.addressTextField.delegate = self
        
//        self.manageAddressUIView.addressTableView.dataSource = self
        
        
        setupMapView()
       
        
    }
    
    func setupAutoCompleteAddressTableView(){
       self.manageAddressUIView.addressTableView.delegate = self
        self.manageAddressUIView.addressTableView.dataSource = self
        
          manageAddressUIView.addressTableView.register(UINib(nibName: "AddressAutoCompleteTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    func setupMapView(){

        dominoShipmentPresenter.setupGoogleMap(mapContainerView: self.manageAddressUIView.mapView, target: CLLocationCoordinate2D(latitude: 3.1412, longitude: 101.68653), zoom: 10)
        
        setupMarker()
    }
    
    func setupMarker(){
        dominoShipmentPresenter.setupMarker(target: CLLocationCoordinate2D(latitude: 3.1412, longitude: 101.68653))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

extension DominoShipmentDetailsViewController: DominoShipmentViewType{
    
    
    func hideAutoCompletionTableView(){
        self.view.bringSubview(toFront: self.manageAddressUIView.mapView)
        self.manageAddressUIView.hideAutoCompletionTableView()
    }
    
    func reloadAddressAutoCompletionData(){
        self.manageAddressUIView.showAutoCompletionTableView()
        self.manageAddressUIView.addressAutoCompleteReloadData()
    }
    
    func setAutoCompleteAddress(address: [GMSAutocompletePrediction]){
        self.arrayAddress = address
        self.manageAddressUIView.showAutoCompletionTableView()
        self.view.bringSubview(toFront: self.manageAddressUIView.addressTableView)
        
//        print(self.arrayAddress)
    }
    
}

extension DominoShipmentDetailsViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let searchString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        //         self.arrayAddress.removeAll()
        
        
        if searchString == ""{
//                 self.view.didMoveToSuperview()
                self.arrayAddress.removeAll()
                self.arrayAddress = [GMSAutocompletePrediction]()
//                self.manageAddressUIView.hideAutoCompletionTableView()
            
            
        }else{
                dominoShipmentPresenter.addressAutoComplete(searchString: searchString)
            self.manageAddressUIView.addressTableView.didMoveToSuperview()
        }
        
        return true
    }
}


extension DominoShipmentDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayAddress.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AddressAutoCompleteTableViewCell
        
        cell.transform = CGAffineTransform(rotationAngle: CGFloat(Float.pi))
        
        if !self.arrayAddress.isEmpty && self.arrayAddress.count > indexPath.row{
            cell.addressLabel.attributedText = arrayAddress[indexPath.row].attributedFullText
        }
        
        
        return cell
    }
    
}


