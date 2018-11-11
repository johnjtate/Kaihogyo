//
//  WorkoutDetailVC.swift
//  Kaihogyo
//
//  Created by John Tate on 11/9/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit
import HealthKit

class WorkoutDetailVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var durationTextLabel: UILabel!
    
    // MARK: - Properties
    var workout: HKWorkout?
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        return formatter
    }()
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    func updateView() {
        guard let workout = workout else { return }
        startTimeLabel.text = dateFormatter.string(from: workout.startDate)
        endTimeLabel.text = dateFormatter.string(from: workout.endDate)
        durationTextLabel.text = String(format: "%.01f", workout.duration) + "s"
    }
}
