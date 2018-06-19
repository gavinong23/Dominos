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
    
    var googleMapView: GMSMapView!
    
    @IBOutlet weak var addressResultTableView: UITableView!
    
    var didClickSubmitAddressButton: ((_ clicked: Bool) -> Void)?
    
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
        self.addressTableView.isHidden = false
        self.mapView.isHidden = false
        
        self.addressResultTableView.transform = CGAffineTransform(rotationAngle: -(CGFloat)(Float.pi))
        
        addSubview(contentView)
        
        contentView.frame = self.bounds
        
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.setupMapView()
        
        addressTableView.removeTheExtraLine()
        addressResultTableView.removeTheExtraLine()
    }
    
    func setupMapView(){
        let camera = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2D(latitude: 3.1412, longitude: 101.68653), zoom: 10)
        self.googleMapView = GMSMapView.map(withFrame: self.mapView.bounds, camera: camera)
        self.mapView.addSubview(self.googleMapView)
    }
    
    func drawMarkerView(marker:GMSMarker){
        marker.map = self.googleMapView
    }
    
    
    @IBAction func submitAddressToSaveOnClick(_ sender: Any) {
        didClickSubmitAddressButton?(true)
    }
    
    func hideAutoCompletionTableView(){
        self.hideChooseAddressView()
        self.hideResultAddressTableView()
        self.showMapView()
    }
    
    func showAutoCompletionTableView(){
        self.showResultAddressTableView()
        self.hideChooseAddressView()
        self.hideMapView()
    }
    
    func addressAutoCompleteReloadData(){
        self.addressResultTableView.reloadData()
    }
    
    @IBAction func addNewAddressOnClick(_ sender: Any) {
        self.showAddNewAddressView()
        self.hideChooseAddressView()
        self.showMapView()
    }
    
    func addAddressButton(isEnabled:Bool){
        addNewAddressButton.isEnabled = isEnabled
    }
    
    func updateMarkerMapView(marker:GMSMarker, place: GMSPlace){
        self.hideResultAddressTableView()
        self.showMapView()
        self.setAddressTextField(formattedAddress: place.formattedAddress!)
        self.updateMapView(marker: marker, coordinate: place.coordinate)
    }
    
    func updateMapView(marker: GMSMarker, coordinate: CLLocationCoordinate2D){
        self.googleMapView.clear()
        self.googleMapView.moveCamera(GMSCameraUpdate.setTarget((coordinate), zoom: 18))
        self.drawMarkerView(marker: marker)
    }
    
    func manageAddressButtonTapSwitchView(){
        self.hideAddNewAddressView()
        self.showChooseAddressView()
    }
    
    func reloadChooseAddressTableView(){
        self.addressTableView.reloadData()
    }
    
    
    func setAddressTextField(formattedAddress:String){
        self.addressTextField.text = formattedAddress
    }
    
    func hideChooseAddressView(){
        self.chooseAddressView.isHidden = true
    }
    
    func hideAddNewAddressView(){
        self.addNewAddressView.isHidden = true
    }
    
    func hideAddressTableView(){
        self.addressTableView.isHidden = true
    }
    
    func hideMapView(){
        self.mapView.isHidden = true
    }
    
    func hideResultAddressTableView(){
        self.addressResultTableView.isHidden = true
    }
    
    func showChooseAddressView(){
        self.chooseAddressView.isHidden = false
    }
    
    func showAddNewAddressView(){
        self.addNewAddressView.isHidden = false
    }
    
    func showAddressTableView(){
        self.addressTableView.isHidden = false
    }
    
    func showResultAddressTableView(){
        self.addressResultTableView.isHidden = false
    }
    
    func showMapView(){
        self.mapView.isHidden = false
    }

}




