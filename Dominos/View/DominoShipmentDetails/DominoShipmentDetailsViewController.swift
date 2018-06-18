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
    
    //The main manage Address View
    func setupManageAddressView(){
        let containerSize = self.manageAddressContainerView.bounds
        manageAddressUIView = ManageAddressUIView(frame: CGRect(x: 0, y: 0, width: containerSize.width, height: containerSize.height))
        self.manageAddressContainerView.addSubview(manageAddressUIView)
      
        
        self.manageAddressUIView.addressTextField.delegate = self
        
        setupAutoCompleteAddressTableView()
        
        drawMarkerView()
        
    }
    
    func drawMarkerView(){
        self.dominoShipmentPresenter.setupMarker(target: CLLocationCoordinate2D(latitude: 3.1412, longitude: 101.68653))
    }
    
    //The table view for main manage Address *** table view *** to show the result of the search address
    func setupAutoCompleteAddressTableView(){
       self.manageAddressUIView.addressResultTableView.delegate = self
        self.manageAddressUIView.addressResultTableView.dataSource = self
        
          manageAddressUIView.addressResultTableView.register(UINib(nibName: "AddressAutoCompleteTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

extension DominoShipmentDetailsViewController: DominoShipmentViewType{
    
    
    func hideAutoCompletionTableView(){
//        self.view.bringSubview(toFront: self.manageAddressUIView.mapView)
        self.manageAddressUIView.hideAutoCompletionTableView()
    }
    
    func reloadAddressAutoCompletionData(){
//        self.manageAddressUIView.showAutoCompletionTableView()
        self.manageAddressUIView.addressAutoCompleteReloadData()
    }
    
    func setAutoCompleteAddress(address: [GMSAutocompletePrediction]){
        self.arrayAddress = address
        self.manageAddressUIView.showAutoCompletionTableView()
//        self.view.bringSubview(toFront: self.manageAddressUIView.addressTableView)
        
//        print(self.arrayAddress)
    }
    
    func drawMarkerView(marker: GMSMarker){
        self.manageAddressUIView.drawMarkerView(marker: marker)
    }
    
    //when user click the row then update the marker, hide the table view, set the address to the text field, and reset the array address
    func updateMapViewMarker(marker: GMSMarker, place: GMSPlace){
        self.manageAddressUIView.updateMarkerMapView(marker:marker, place: place)
        self.arrayAddress.removeAll()
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
                self.manageAddressUIView.hideAutoCompletionTableView()
            
            
        }else{
                dominoShipmentPresenter.addressAutoComplete(searchString: searchString)
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
        
//        print("i m here cell table vidaiaka")
        
        cell.transform = CGAffineTransform(rotationAngle: CGFloat(Float.pi))
        
        if !self.arrayAddress.isEmpty && self.arrayAddress.count > indexPath.row{
            cell.addressLabel.attributedText = arrayAddress[indexPath.row].attributedFullText
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.arrayAddress.count > indexPath.row{
            
            self.dominoShipmentPresenter.getPlaceDetail(placeID: arrayAddress[indexPath.row].placeID!)
            
        }
    }
    
}


