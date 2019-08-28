//
//  BurritoPlace.swift
//  BurritoChallenge
//
//  Created by Ryan Manalo on 8/28/19.
//  Copyright © 2019 Manalo Dev. All rights reserved.
//

import Foundation

class BurritoPlace: NSObject {
    var name: String
    var address: String
    var stars: Float
    var lat: Double
    var lng: Double
    
    init(name: String, address: String, stars: Float, lat: Double, lng: Double) {
        self.name = name
        self.address = address
        self.stars = stars
        self.lat = lat
        self.lng = lng
    }
    
    static func parse(dict: [String: Any]) -> BurritoPlace? {
        guard
            let name = dict["name"] as? String,
            let address = dict["vicinity"] as? String,
            let stars = dict["rating"] as? Float,
            let geometry = dict["geometry"] as? [String: Any],
            let location = geometry["location"] as? [String: Double],
            let lat = location["lat"],
            let lng = location["lng"]
        else { return nil }
        
        return BurritoPlace(name: name, address: address, stars: stars, lat: lat, lng: lng)
    }
}
