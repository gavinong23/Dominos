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
    
    private let dominoShipmentPresenter = DominoShipmentPresenter(userService:UserService(), locationService:LocationService(), pizzaService: PizzaService())
    
    @IBOutlet weak var manageAddressContainerView: UIView!
    
    var arrayAddress = [GMSAutocompletePrediction]()
    
    var arraySavedAddress = [UserAddressModel]()
    
    weak var dominoCheckoutViewController: DominoCheckoutViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.dominoShipmentPresenter.getParticularUserAddress(userID: "1")
        setupManageAddressView()
        manageAddressUIView.addAddressButton(isEnabled: true)
        
        
        
    }
    
    func setupView(){
        dominoShipmentPresenter.attachView(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.dominoShipmentPresenter.getParticularUserAddress(userID: "1")
    }
    
    //The main manage Address View
    func setupManageAddressView(){
        let containerSize = self.manageAddressContainerView.bounds
        manageAddressUIView = ManageAddressUIView(frame: CGRect(x: 0, y: 0, width: containerSize.width, height: containerSize.height))
        self.manageAddressContainerView.addSubview(manageAddressUIView)
      
        self.manageAddressUIView.addressTextField.delegate = self
        setupAutoCompleteAddressResultTableView()
        setupAddressTableView()
        drawMarkerView()
        SubmitAddressOnClick()
    }
    
    func drawMarkerView(){
        self.dominoShipmentPresenter.setupMarker(target: CLLocationCoordinate2D(latitude: 3.1412, longitude: 101.68653))
    }
    
    func SubmitAddressOnClick(){
        self.manageAddressUIView.didClickSubmitAddressButton = { (clicked) in
            if clicked{
                self.dominoShipmentPresenter.confirmationUploadAddress()
            }
            
        }
    }
    
    //The table view for main manage Address *** table view *** to show the result of the search address
    func setupAutoCompleteAddressResultTableView(){
       self.manageAddressUIView.addressResultTableView.delegate = self
       self.manageAddressUIView.addressResultTableView.dataSource = self
        
        manageAddressUIView.addressResultTableView.register(R.nib.addressAutoCompleteTableViewCell(), forCellReuseIdentifier: R.reuseIdentifier.cell.identifier)
        
    }
    
    //setup the address table for choose the saved address
    func setupAddressTableView(){
        self.manageAddressUIView.addressTableView.delegate = self
        self.manageAddressUIView.addressTableView.dataSource = self
        
        manageAddressUIView.addressTableView.register(R.nib.addressAutoCompleteTableViewCell(), forCellReuseIdentifier: R.reuseIdentifier.cell.identifier)
        
       
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func manageAddressButtonOnClick(_ sender: Any) {
        self.manageAddressUIView.manageAddressButtonTapSwitchView() 
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
    
    //when user click the row then update the marker, hide the table view, set the address to the text field, and reset the array address // update view when address tap
    func updateViewWhenAddressResultViewRowTap(marker: GMSMarker, place: GMSPlace){
        self.manageAddressUIView.updateMarkerMapView(marker:marker, place: place)
        self.arrayAddress.removeAll()
    }
    
    func setChooseAddressView(addresses: [UserAddressModel]){
        self.arraySavedAddress = addresses
        self.manageAddressUIView.reloadChooseAddressTableView()
        
    }
    
    func showConfirmationBoxForAddAddress(title:String, message: String) {
        let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action: UIAlertAction!) in
          
            self.dominoShipmentPresenter.uploadNewAddressToServer(uploadAddressText: self.manageAddressUIView.addressTextField.text!)
          
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func showConfirmationBoxForChoosenAddress(title:String, message: String){
        let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action: UIAlertAction!) in
            //self.dominoShipmentPresenter.routeTo()
           // self.delegate.shipmentDetailsUIView.shipmentOwnerAddressLabel.text = "gg"
           self.dominoShipmentPresenter.routeTo()
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    
    }
    
    func showAlertBox(title:String,message:String){
        let alert = UIAlertController(title: title , message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func switchToChooseAddressViewAfterAddedNewAddress(){
        self.manageAddressUIView.afterAddedNewAddressSwitchBackToChooseAddressView()
    }
    
    func deleteAddressUpdateView(row: Int, indexPath: IndexPath){
        self.arraySavedAddress.remove(at: row)
        self.manageAddressUIView.deleteAddressRow(indexPath: indexPath)
    }
    
    func searchAddressStringNull(){
        
        self.arrayAddress.removeAll()
        self.arrayAddress = [GMSAutocompletePrediction]()
        self.manageAddressUIView.hideAutoCompletionTableView()
    }
    
    func routeTo(address: String) {
        self.dominoCheckoutViewController.updateShipmentAddressView(address: address)
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension DominoShipmentDetailsViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let searchString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        dominoShipmentPresenter.addressAutoComplete(searchString: searchString)
        
        return true
    }
}

extension DominoShipmentDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count: Int = 0
        
        if tableView == self.manageAddressUIView.addressResultTableView{
              count = self.arrayAddress.count
        }else if tableView == self.manageAddressUIView.addressTableView{
            count = self.arraySavedAddress.count
        }else{
            count = 0
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell? = nil
        
        if tableView == self.manageAddressUIView.addressResultTableView{
            
        
            if !self.arrayAddress.isEmpty && self.arrayAddress.count > indexPath.row{
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AddressAutoCompleteTableViewCell
                
                //        print("i m here cell table vidaiaka")
                
                
    
                cell.transform = CGAffineTransform(rotationAngle: CGFloat(Float.pi))
                cell.addressLabel.attributedText = arrayAddress[indexPath.row].attributedFullText
                
                return cell
            }

        }else{
//            return cell
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AddressAutoCompleteTableViewCell
            
            cell.addressLabel.text = arraySavedAddress[indexPath.row].address
            
            return cell
        }
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if tableView == self.manageAddressUIView.addressTableView{
            
            self.dominoShipmentPresenter.confirmationChooseAddress(selectedAddress: self.arraySavedAddress[indexPath.row].addressID!)
            
        }else if tableView == self.manageAddressUIView.addressResultTableView{
            
            if self.arrayAddress.count > indexPath.row{
                
                self.dominoShipmentPresenter.getPlaceDetail(placeID: arrayAddress[indexPath.row].placeID!)
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if tableView == self.manageAddressUIView.addressTableView{
            
            let address = self.arraySavedAddress[indexPath.row]
        
            if let addressID = address.addressID{
                
                if self.arraySavedAddress.count > indexPath.row{
              
                    self.dominoShipmentPresenter.deleteParticularAddress(addressID: addressID, row: indexPath.row, indexPath: indexPath)
                    
                }
            }
        }
    }
    
}


