//
//  LocationService.swift
//  Dominos
//
//  Created by Gavin Ong on 14/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation
import GoogleMaps
import GooglePlaces




class LocationService{
    
    func setupGoogleMap(mapContainerView:UIView, target: CLLocationCoordinate2D, zoom: Float){
        LocationManager.instance.initializeMap(mapContainerView: mapContainerView, target: target, zoom: zoom)
    }
    
    
    func setupMarker(target:CLLocationCoordinate2D){
        LocationManager.instance.drawMarker(target: target)
    }
    
    func autoCompleteAddress(searchString: String,onSuccess successCallback: ((_ addresses: [GMSAutocompletePrediction]) -> Void)?, onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        
        LocationManager.instance.autoCompleteAddress(searchString: searchString, onSuccess: { (addresses) in
            successCallback?(addresses)
        }, onFailure: { (errorMessage) in
            failureCallback?(errorMessage)
        })
        
    }
    
    
    
}
