//
//  LocationManager.swift
//  Dominos
//
//  Created by Gavin Ong on 14/6/18.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import GooglePlaces


class LocationManager{
    
    static let instance = LocationManager()
    let locationManager = CLLocationManager()
    var mapView: GMSMapView!
    var marker = GMSMarker()
    
    var arrayAddress = [GMSAutocompletePrediction]()
    
    lazy var filter: GMSAutocompleteFilter = {
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        
        return filter
    }()
    
    func setupGoogleMapAPI() -> Bool{
        
        if(GMSServices.provideAPIKey(Config.ApiKey.GOOGLE_MAP_API_KEY) && GMSPlacesClient.provideAPIKey(Config.ApiKey.GOOGLE_MAP_API_KEY)){
              return true
        }else{

            return false
        }
    }
    
    func drawMarker(target: CLLocationCoordinate2D) -> GMSMarker{
            self.marker = GMSMarker()

            marker.position = target
        
            return marker
    }
    
    func drawMarker(title: String, target: CLLocationCoordinate2D) -> GMSMarker{
        self.marker = GMSMarker()
        
        marker.position = target
        marker.title = title

        return marker
    }
    

    
    func autoCompleteAddress(searchString:String,onSuccess successCallback: ((_ address: [GMSAutocompletePrediction]) -> Void)?, onFailure failureCallback: ((_ errorMessage: Error) -> Void)?){
        
            GMSPlacesClient.shared().autocompleteQuery(searchString, bounds: nil, filter: self.filter, callback: { (result, error) in
                if error == nil && result != nil{
                    
                    successCallback?(result!)
                    
                }else{
                   // print(error)
                
                    failureCallback?(error!)
                }
                })
    }
    
    // get the particular address's place id's details such as longitude, latitude etc.
    func getParticularAddressDetail(placeID: String, onSuccess successCallback: ((_ place: GMSPlace) -> Void)?, onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        
        GMSPlacesClient.shared().lookUpPlaceID(placeID, callback: { (result, error) in
            
            if error == nil && result != nil{
                
                successCallback?(result!)
                
            }else{
                
                failureCallback?(error as! String)
            }

            })
    }
    
    
    //    func setupCurrentLocation(){
    //        self.locationManager.requestAlwaysAuthorization()
    //
    //        self.locationManager.requestWhenInUseAuthorization()
    //
    //        if CLLocationManager.locationServicesEnabled(){
    ////            locationManager.delegate = self
    //            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    //            locationManager.startUpdatingLocation()
    //        }
    //    }
    
    //    func intializeMap(mapContainerView: UIView, latitude: CLLocationDegrees, longitude: CLLocationDegrees, zoom: Float){
    //
    //        if(self.setupGoogleMapAPI()){
    //            let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: zoom)
    //
    //            self.mapView = GMSMapView.map(withFrame: mapContainerView.bounds, camera: camera)
    //
    //            mapContainerView.addSubview(self.mapView)
    //        }
    //    }
    
    //    func initializeMap(mapContainerView:UIView, target: CLLocationCoordinate2D, zoom: Float){
    //
    //        if(self.setupGoogleMapAPI()){
    //
    //            let camera = GMSCameraPosition.camera(withTarget: target, zoom: zoom)
    //
    //            self.mapView = GMSMapView.map(withFrame: mapContainerView.bounds, camera: camera)
    //
    //            mapContainerView.addSubview(self.mapView)
    //        }
    //
    //    }
    
    
    //    func drawMarker(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
    //        if self.mapView != nil{
    //            self.marker = GMSMarker()
    //            marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    //            marker.map = mapView
    //        }
    //    }
    
    //    func updateMap(target: CLLocationCoordinate2D, zoom: Float){
    //        self.mapView.clear()
    //        self.mapView.moveCamera(GMSCameraUpdate.setTarget(target, zoom: zoom))
    ////        GMSPlacesClient.shared().loo
    //    }
    
    
}
