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
    @IBOutlet weak var cardBackground: UIView!
    
    var burritoPlace: BurritoPlace? {
        didSet {
            guard let burritoPlace = self.burritoPlace else { return }
            placeNameLabel.text = burritoPlace.name
            addressLabel.text = burritoPlace.address
            statsLabel.text = "$ · \(burritoPlace.stars) ★s"
        }
    }
    
    override func awakeFromNib() {
        cardBackground.layer.cornerRadius = 5
        cardBackground.layer.masksToBounds = false
        cardBackground.layer.shadowColor = UIColor.black.cgColor
        cardBackground.layer.shadowOpacity = 0.3
        cardBackground.layer.shadowOffset = CGSize(width: 4, height: -4)
        cardBackground.layer.shadowRadius = 5
    }
}
