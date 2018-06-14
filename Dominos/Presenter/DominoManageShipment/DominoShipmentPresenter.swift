//
//  DominoShipmentPresenter.swift
//  Dominos
//
//  Created by Gavin Ong on 14/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces
import GoogleMaps



class DominoShipmentPresenter{
    
     private let locationService: LocationService
     weak private var dominoShipmentView : DominoShipmentViewType?
    
    init(locationService: LocationService){

        self.locationService = locationService
    }
    
    func attachView(view: DominoShipmentViewType){
        dominoShipmentView = view
    }
    
    func detachView(){
        dominoShipmentView = nil
        
    }
    
    
    func setupGoogleMap(mapContainerView:UIView, target: CLLocationCoordinate2D,zoom : Float){
        self.locationService.setupGoogleMap(mapContainerView: mapContainerView, target: target, zoom: zoom)
    }
    
    func setupMarker(target:CLLocationCoordinate2D){
        self.locationService.setupMarker(target: target)
    }
    
    func addressAutoComplete(searchString: String){
        self.locationService.autoCompleteAddress(searchString: searchString, onSuccess: { (addresses) in
            
            if addresses.count > 0{
                self.dominoShipmentView?.setAutoCompleteAddress(address: addresses)
//                print(addresses)
                self.dominoShipmentView?.reloadAddressAutoCompletionData()
            }else{
                self.dominoShipmentView?.hideAutoCompletionTableView()
            }
           
            
       
        }, onFailure: { (errorMessage) in
            print(errorMessage)
        })
    }
    
}
