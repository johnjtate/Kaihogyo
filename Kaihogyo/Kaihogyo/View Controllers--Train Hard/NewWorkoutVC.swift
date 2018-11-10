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
    
    // MARK: - Properties
    
    var workoutTimer: Timer!
    var runWorkoutSession = RunWorkoutSession()
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        workoutTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.updateLabels()
        })
        finishButtonStatus()
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        runWorkoutSession.clearRun()
        finishButtonStatus()
    }
    
    // MARK: - Helper Functions
    
    // setup UI
    func setUpUI() {
        startRunWorkoutButton.layer.masksToBounds = true
        startRunWorkoutButton.layer.cornerRadius = 5.0
        finishAndSaveWorkoutButton.layer.masksToBounds = true
        finishAndSaveWorkoutButton.layer.cornerRadius = 5.0
    }
    
    func finishButtonStatus() {
        var isEnabled = false
        
        switch runWorkoutSession.workoutState {
        case .notStarted, .inProgress:
            isEnabled = false
        case .completed:
            isEnabled = true
        }
        finishAndSaveWorkoutButton.isEnabled = isEnabled
    }
    
    lazy var workoutTimerFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        return formatter
    }()
    
    func updateLabels() {
        switch runWorkoutSession.workoutState {
        case .inProgress:
            let duration = Date().timeIntervalSince(runWorkoutSession.startTime)
            timerTextLabel.text = workoutTimerFormatter.string(from: duration)
        case .completed:
            let duration = runWorkoutSession.endTime.timeIntervalSince(runWorkoutSession.startTime)
            timerTextLabel.text = workoutTimerFormatter.string(from: duration)
        default:
            timerTextLabel.text = nil
        }
    }
    
    func updateButton() {
        switch runWorkoutSession.workoutState {
        case .notStarted:
            startRunWorkoutButton.setTitle("Start Run Workout", for: .normal)
            startRunWorkoutButton.backgroundColor = .green
        case .inProgress:
            startRunWorkoutButton.setTitle("Stop Run Workout", for: .normal)
            startRunWorkoutButton.backgroundColor = .red
        case .completed:
            startRunWorkoutButton.setTitle("New Run", for: .normal)
            startRunWorkoutButton.backgroundColor = .green
        }
    }
    
    func beginWorkout() {
        runWorkoutSession.startRun()
        updateLabels()
        finishButtonStatus()
    }
    
    func finishWorkout() {
        runWorkoutSession.endRun()
        updateLabels()
        finishButtonStatus()
    }
    
    // MARK: - IBActions
    
    @IBAction func startRunWorkoutButtonTapped(_ sender: Any) {
        switch runWorkoutSession.workoutState {
        case .notStarted, .completed:
            self.beginWorkout()
            updateButton()
            finishButtonStatus()
            print("start/stop button pressed")
            print("\(runWorkoutSession.workoutState)")
        case .inProgress:
            updateButton()
            finishButtonStatus()
            finishWorkout()
        }
    }
    
    @IBAction func finishAndSaveWorkoutButtonTapped(_ sender: Any) {
        print("finish and save button pressed")
        print("\(runWorkoutSession.workoutState)")
        print("\(String(describing: runWorkoutSession.completedRunWorkout))")
        
        // button is diabled when workout is in progress via finishButtonStatus(), but also handle that case here
        guard let currentWorkout = runWorkoutSession.completedRunWorkout else {
            fatalError("shouldn't be able to press finish button without saved workout")
        }
        
        WorkoutController.shared.save(runWorkout: currentWorkout) { (success, error) in
            if success {
                print("successfully saved workout")
                self.dismissAndRefreshWorkouts()
            } else {
                print("did not save workout")
                self.displayProblemSavingWorkoutAlert()
            }
        }
    }
    
    func dismissAndRefreshWorkouts() {
        runWorkoutSession.clearRun()
    }
    
    func displayProblemSavingWorkoutAlert() {
        let problemSavingAlert = UIAlertController(title: nil, message: "There was a problem saving your workout", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        problemSavingAlert.addAction(okayAction)
        present(problemSavingAlert, animated: true, completion: nil)
    }
}

