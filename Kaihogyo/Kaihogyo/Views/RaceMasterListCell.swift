//
//  RaceMasterListCell.swift
//  Kaihogyo
//
//  Created by John Tate on 11/1/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class RaceMasterListCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var raceNameTextLabel: UILabel!
    @IBOutlet weak var raceLocationTextLabel: UILabel!
    @IBOutlet weak var raceDateTextLabel: UILabel!
    @IBOutlet weak var raceLogoImageView: UIImageView!
    
    // MARK: - Properties
    var race: Race? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateView() {
        guard let race = race else { return }
        raceNameTextLabel.text = race.race.name ?? ""
        let raceCity = race.race.address.city ?? ""
        let raceState = race.race.address.state ?? ""
        raceLocationTextLabel.text = "\(String(describing: raceCity))" + "," + "\(String(describing: raceState))"
        raceDateTextLabel.text = race.race.date ?? ""
    }
}
