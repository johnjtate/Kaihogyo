//
//  RaceListDetailVC.swift
//  Kaihogyo
//
//  Created by John Tate on 11/2/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class RaceListDetailVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var raceLogoImageView: UIImageView!
    @IBOutlet weak var raceNameTextLabel: UILabel!
    @IBOutlet weak var raceDateTextLabel: UILabel!
    @IBOutlet weak var raceAddressTextLabel: UILabel!
    @IBOutlet weak var runSignUpURLButton: UIButton!
    @IBOutlet weak var externalURLButton: UIButton!
    
    // MARK: - Properties
    var race: Race? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    var runSignUpURL: URL?
    var raceSiteURL: URL?
    
    func updateViews() {
    
        guard let race = race else { return }
        raceNameTextLabel.text = race.race.name ?? ""
        raceDateTextLabel.text = race.race.date ?? ""
        let raceStreet = race.race.address.street ?? ""
        let raceCity = race.race.address.city ?? ""
        let raceState = race.race.address.state ?? ""
        let raceZIP = race.race.address.zipcode ?? ""
        raceAddressTextLabel.text = "\(raceStreet)" + ", " + "\(raceCity)" + ", " + "\(raceState)" + ", " + "\(raceZIP)"
        
        if let url = race.race.url {
            runSignUpURLButton.isHidden = false
            runSignUpURLButton.setTitle("RunSignUp Website", for: .normal)
            runSignUpURL = url
        } else {
            runSignUpURLButton.isHidden = true
        }
        
        if let externalURL = race.race.externalURL {
            externalURLButton.isHidden = false
            externalURLButton.setTitle("Race Website", for: .normal)
            raceSiteURL = externalURL
        } else {
            externalURLButton.isHidden = true
        }
    }
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - IBActions
    @IBAction func runSignUpURLButtonTapped(_ sender: Any) {
        guard let url = runSignUpURL else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func externalURLButtonTapped(_ sender: Any) {
        guard let url = raceSiteURL else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
