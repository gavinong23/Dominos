//
//  DominoShipmentViewType.swift
//  Dominos
//
//  Created by Gavin Ong on 14/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation
import GooglePlaces
import GoogleMaps



protocol DominoShipmentViewType : NSObjectProtocol {
    
    func reloadAddressAutoCompletionData()
    func setAutoCompleteAddress(address: [GMSAutocompletePrediction])
    func hideAutoCompletionTableView()
    func drawMarkerView(marker: GMSMarker)
    func updateViewWhenAddressResultViewRowTap(marker: GMSMarker, place: GMSPlace)
    func setChooseAddressView(addresses: [UserAddressModel])
    func showAlertBox(title: String, message: String)
    func showConfirmationBoxForAddAddress(title:String, message: String)
    func switchToChooseAddressViewAfterAddedNewAddress()
    func deleteAddressUpdateView(row: Int, indexPath: IndexPath)
    func searchAddressStringNull()
    func showConfirmationBoxForChoosenAddress(title:String, message: String)
    func routeTo(address:String)
}
