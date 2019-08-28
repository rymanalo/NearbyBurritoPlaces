//
//  MapViewController.swift
//  BurritoChallenge
//
//  Created by Ryan Manalo on 8/28/19.
//  Copyright © 2019 Manalo Dev. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var statsLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var burritoPlace: BurritoPlace!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = burritoPlace.name
        addressLabel.text = burritoPlace.address
        statsLabel.text = "$ · \(burritoPlace.stars) ★s"
        
        setupMapView()
    }
    
    func setupMapView() {
        mapView.delegate = self
        let location = CLLocation(latitude: burritoPlace.lat, longitude: burritoPlace.lng)
        centerMapOnLocation(location: location)

        let marker = MKPointAnnotation()
        marker.coordinate = location.coordinate
        mapView.addAnnotation(marker)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 5000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: nil)
        annotationView.markerTintColor = UIColor(red: 110/255, green: 0, blue: 1, alpha: 1.0)
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard
            let encodedString = burritoPlace.address.replacingOccurrences(of: ",", with: "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: "http://maps.apple.com/?daddr=\(encodedString)"),
            UIApplication.shared.canOpenURL(url)
        else { return }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
