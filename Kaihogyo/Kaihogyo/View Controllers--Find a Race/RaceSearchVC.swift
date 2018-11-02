//
//  RaceSearchVC.swift
//  Kaihogyo
//
//  Created by John Tate on 11/1/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class RaceSearchVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var minDistanceTextField: UITextField!
    @IBOutlet weak var maxDistanceTextField: UITextField!
    @IBOutlet weak var distanceUnitsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var radiusTextField: UITextField!
    @IBOutlet weak var ZIPCodeTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var clearAllButton: UIButton!
    @IBOutlet weak var searchForRaceButton: UIButton!
    
    // MARK: - Properties
    
    var statePicker = UIPickerView()
    var minDistance: String = ""
    var maxDistance: String = ""
    var distanceUnits: String = "M"
    var radius: String = ""
    var ZIPCode: String = ""
    var city: String = ""
    var state: String = ""
    let activityIndicator = ActivityIndicator.shared
    
    func searchForRaces() {
        
        RaceController.shared.fetchRaces(min_distance: minDistance, max_distance: maxDistance, distance_units: distanceUnits, radius: radius, zipcode: ZIPCode, city: city, state: state) { (races) in
         
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating(navigationItem: self.navigationItem)
                self.performSegue(withIdentifier: "toRacesTableView", sender: nil)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cityTextField.resignFirstResponder()
        stateTextField.resignFirstResponder()
        return true
    }
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTextField.delegate = self
        statePicker.dataSource = self
        statePicker.delegate = self
        stateTextField.inputView = statePicker
        
        //Tap anywhere on the screen to dismiss keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(sender:)))
        self.view.addGestureRecognizer(tap)
    }
    
    // MARK: - Tap Gesture Helper Function
    @objc func handleScreenTap(sender: UITapGestureRecognizer) {
        //this works with the UITapGesture Recognizer to help dismiss the keyboard
        self.view.endEditing(true)
    }
    
    // MARK: - Data Arrays for Picker Views
    
    var stateAbbreviations = ["", "AK", "AL", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stateAbbreviations.count
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        stateTextField.text = stateAbbreviations[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stateAbbreviations[row]
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Navigation Controllers
    
    func negativeMinimumDistanceAlert() {
        let negativeMinimumDistanceAlert = UIAlertController(title: "Please enter a minimum distance of 0 or more.", message: nil, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        negativeMinimumDistanceAlert.addAction(okayAction)
        self.present(negativeMinimumDistanceAlert, animated: true)
    }
    
    func negativeMaximumDistanceAlert() {
        let negativeMaximumDistanceAlert = UIAlertController(title: "Please enter a maxiumum distance of more than 0.", message: nil, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        negativeMaximumDistanceAlert.addAction(okayAction)
        self.present(negativeMaximumDistanceAlert, animated: true)
    }
    
    func reversedDistancesAlert() {
        let reversedDistancesAlert = UIAlertController(title: "Please enter a maximum distance that is greater than or equal to the minimum distance.", message: nil, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        reversedDistancesAlert.addAction(okayAction)
        self.present(reversedDistancesAlert, animated: true)
    }
    
    func negativeRadiusAlert() {
        let negativeRadiusAlert = UIAlertController(title: "Please enter a distance of more than 0 miles from the ZIP code.", message: nil, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        negativeRadiusAlert.addAction(okayAction)
        self.present(negativeRadiusAlert, animated: true)
    }
    
    func invalidZIPCodeAlert() {
        let invalidZIPCode = UIAlertController(title: "Please enter a 5-digit ZIP code.", message: nil, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        invalidZIPCode.addAction(okayAction)
        self.present(invalidZIPCode, animated: true)
    }
    
    // MARK: - IBAction
    
    @IBAction func distanceSegmentedControlToggled(_ sender: Any) {
        if distanceUnitsSegmentedControl.selectedSegmentIndex == 0 {
            distanceUnits = "M"
        } else if distanceUnitsSegmentedControl.selectedSegmentIndex == 1 {
            distanceUnits = "K"
        }
    }
    
    @IBAction func clearAllButtonTapped(_ sender: Any) {
        minDistanceTextField.text = ""
        maxDistanceTextField.text = ""
        radiusTextField.text = ""
        ZIPCodeTextField.text = ""
        cityTextField.text = ""
        stateTextField.text = ""
    }
    
    @IBAction func searchForRaceButtonTapped(_ sender: Any) {
        
        DispatchQueue.main.async {
            self.activityIndicator.animateActivity(title: "Searching...", view: self.view, navigationItem: self.navigationItem)
        }
        
        if let minDistance = minDistanceTextField.text {
            self.minDistance = minDistance
            if !minDistance.isEmpty {
                if Double(minDistance)! < 0.0 {
                    negativeMinimumDistanceAlert()
                }
            }
        }
        
        if let maxDistance = maxDistanceTextField.text {
            self.maxDistance = maxDistance
            if !maxDistance.isEmpty {
                if Double(maxDistance)! <= 0.0 {
                    negativeMaximumDistanceAlert()
                }
            }
            if !maxDistance.isEmpty && !minDistance.isEmpty {
                if Double(maxDistance)! < Double(minDistance)! {
                    reversedDistancesAlert()
                }
            }
        }
        
        if let radius = radiusTextField.text {
            self.radius = radius
            if !radius.isEmpty {
                if Double(radius)! <= 0.0 {
                    negativeRadiusAlert()
                }
            }
        }
        
        if let ZIPCode = ZIPCodeTextField.text {
            self.ZIPCode = ZIPCode
            if !ZIPCode.isEmpty {
                if ZIPCode.count != 5 {
                    invalidZIPCodeAlert()
                }
            }
        }
    
        if let city = cityTextField.text {
            self.city = city
        }
        
        if let state = stateTextField.text {
            self.state = state
        }

        searchForRaces()
    }
}

