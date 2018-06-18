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
    
//    func setupGoogleMap(mapContainerView:UIView, target: CLLocationCoordinate2D, zoom: Float){
//        LocationManager.instance.initializeMap(mapContainerView: mapContainerView, target: target, zoom: zoom)
//    }
//    
    
    func setupMarker(target:CLLocationCoordinate2D) -> GMSMarker{
        return(LocationManager.instance.drawMarker(target: target))
    }
    
    func setupMarkerWithTitle(title: String, target: CLLocationCoordinate2D) -> GMSMarker{
        return(LocationManager.instance.drawMarker(title: title, target: target))
    }
    
    func setupGoogleMapAPI(){
        
        // here can do store bool to the user defaults to check whether the api is valid, then if valid only let user create map
        if(LocationManager.instance.setupGoogleMapAPI()){
            print("Valid Google Map API Key.")
        }else{
            print("Invalid Google Map API Key.")
        }
    }
    
    func getPlaceDetail(placeID: String, onSuccess successCallback:((_ place: GMSPlace)-> Void)?, onFailure failureCallback: ((_ errorMessage: String)-> Void)?){
        
        LocationManager.instance.getParticularAddressDetail(placeID: placeID, onSuccess: { (place) in
            successCallback?(place)
        }, onFailure: { (errorMessage) in
            failureCallback?(errorMessage)
        })
    }
    
    func autoCompleteAddress(searchString: String,onSuccess successCallback: ((_ addresses: [GMSAutocompletePrediction]) -> Void)?, onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        
        LocationManager.instance.autoCompleteAddress(searchString: searchString, onSuccess: { (addresses) in
            successCallback?(addresses)
        }, onFailure: { (errorMessage) in
            failureCallback?(errorMessage)
        })
        
    }
    
    
    
}
