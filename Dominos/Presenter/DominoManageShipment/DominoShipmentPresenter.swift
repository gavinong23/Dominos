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
    
    
//    func setupGoogleMap(mapContainerView:UIView, target: CLLocationCoordinate2D,zoom : Float){
////        self.locationService.setupGoogleMap(mapContainerView: mapContainerView, target: target, zoom: zoom)
//    }
    
    func setupMarker(target:CLLocationCoordinate2D) {
        
        //set marker to the view
        let marker = self.locationService.setupMarker(target: target)
        
        self.dominoShipmentView?.drawMarkerView(marker: marker)
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
    
    func getPlaceDetail(placeID: String){
        self.locationService.getPlaceDetail(placeID: placeID, onSuccess: { (place) in
//            self.locationService.place.coordinate
            let marker = self.locationService.setupMarkerWithTitle(title: place.name,target: place.coordinate)
            
            self.dominoShipmentView?.updateMapViewMarker(marker: marker, place: place)
            
        }, onFailure: { (errorMessage) in
            //
        })
    }
    
}
