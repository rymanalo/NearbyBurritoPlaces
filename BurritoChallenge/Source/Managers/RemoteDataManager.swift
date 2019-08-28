//
//  RemoteDataManager.swift
//  BurritoChallenge
//
//  Created by Ryan Manalo on 8/28/19.
//  Copyright © 2019 Manalo Dev. All rights reserved.
//

import Foundation

enum BurritoError: String, Error {
    case error = "Something went wrong!"
}

struct RemoteDataManager {
    
    let API_KEY = "API_KEY"
    
    func fetchBurritoPlacesNear(lat: Double, lng: Double, completion: @escaping (_ burritoPlaces: [BurritoPlace]?, _ error: Error?) -> () ) {
        let googlePlacesUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(lat),\(lng)&rankby=distance&type=restaurant&keyword=burrito&key=\(API_KEY)"
        
        guard let url = URL(string: googlePlacesUrl) else {
            completion(nil, BurritoError.error)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let data = data,
                let jsonData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                let results = jsonData["results"] as? [[String: Any]]
            else {
                completion(nil, BurritoError.error)
                return
            }
            
            var burritoPlaces = [BurritoPlace]()
            for result in results {
                guard let burritoPlace = BurritoPlace.parse(dict: result) else { continue }
                burritoPlaces.append(burritoPlace)
            }
            
            completion(burritoPlaces, nil)
            
        }.resume()
    }
}
