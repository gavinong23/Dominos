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
    func updateMapViewMarker(marker: GMSMarker, place: GMSPlace)
}
