//
//  BurritoPlaceTableViewCell.swift
//  BurritoChallenge
//
//  Created by Ryan Manalo on 8/28/19.
//  Copyright © 2019 Manalo Dev. All rights reserved.
//

import UIKit

class BurritoPlaceTableViewCell: UITableViewCell {

    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var statsLabel: UILabel!
    
    var burritoPlace: BurritoPlace? {
        didSet {
            guard let burritoPlace = self.burritoPlace else { return }
            placeNameLabel.text = burritoPlace.name
            addressLabel.text = burritoPlace.address
            statsLabel.text = "$ · \(burritoPlace.stars) ★s"
        }
    }
}
