//
//  BurritoCLManager.swift
//  BurritoChallenge
//
//  Created by Ryan Manalo on 8/28/19.
//  Copyright © 2019 Manalo Dev. All rights reserved.
//

import Foundation
import CoreLocation

protocol BurritoCLManagerDelegate {
    func didUpdateLocation(location: CLLocation?)
}

class BurritoCLManager: NSObject {
    var locationManager = CLLocationManager()
    static var delegate: BurritoCLManagerDelegate?
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        checkForLocationServicesAuthorization()
    }
    
    func checkForLocationServicesAuthorization() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

extension BurritoCLManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        BurritoCLManager.delegate?.didUpdateLocation(location: locations.first)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}
