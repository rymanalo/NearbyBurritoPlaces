//
//  BurritoTableViewController.swift
//  BurritoChallenge
//
//  Created by Ryan Manalo on 8/28/19.
//  Copyright © 2019 Manalo Dev. All rights reserved.
//

import UIKit
import CoreLocation

class BurritoTableViewController: UITableViewController {
    
    var burritoPlaces = [BurritoPlace]()
    var locationManager: BurritoCLManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.reloadData()
        locationManager = BurritoCLManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BurritoCLManager.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return burritoPlaces.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "burritoPlace", for: indexPath) as? BurritoPlaceTableViewCell {
            let index = indexPath.row
            let burritoPlace = burritoPlaces[index]
            
            cell.burritoPlace = burritoPlace
            cell.selectionStyle = .none
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let burritoPlace = burritoPlaces[index]
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        if let mapVC = sb.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController {
            mapVC.burritoPlace = burritoPlace
            
            navigationController?.pushViewController(mapVC, animated: true)
        }
    }
    
}

// MARK: - BurritoCLManagerDelegate

extension BurritoTableViewController: BurritoCLManagerDelegate {
    func didUpdateLocation(location: CLLocation?) {
        guard let location = location else { return }
        
        let remoteDataManager = RemoteDataManager()
        remoteDataManager.fetchBurritoPlacesNear(lat: location.coordinate.latitude, lng: location.coordinate.longitude) { (burritoPlaces, error) in
            guard let burritoPlaces = burritoPlaces, error == nil else { return }
            
            self.burritoPlaces = burritoPlaces
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
