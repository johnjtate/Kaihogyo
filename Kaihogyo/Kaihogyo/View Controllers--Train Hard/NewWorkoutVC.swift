//
//  NewWorkoutVC.swift
//  Kaihogyo
//
//  Created by John Tate on 11/9/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class NewWorkoutVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var startRunWorkoutButton: UIButton!
    @IBOutlet weak var timerTextLabel: UILabel!
    @IBOutlet weak var finishAndSaveWorkoutButton: UIButton!
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    // MARK: - Helper Functions
    
    // setup UI
    func setUpUI() {
        startRunWorkoutButton.layer.masksToBounds = true
        startRunWorkoutButton.layer.cornerRadius = 5.0
        finishAndSaveWorkoutButton.layer.masksToBounds = true
        finishAndSaveWorkoutButton.layer.cornerRadius = 5.0
    }
    
    
    // MARK: - IBActions
    
    @IBAction func startRunWorkoutButtonTapped(_ sender: Any) {
    }
    
    @IBAction func finishAndSaveWorkoutButtonTapped(_ sender: Any) {
    }
}
