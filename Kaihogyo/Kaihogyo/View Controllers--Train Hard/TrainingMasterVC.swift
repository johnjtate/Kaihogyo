//
//  TrainingMasterVC.swift
//  Kaihogyo
//
//  Created by John Tate on 11/2/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit
import HealthKit

class TrainingMasterVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var startNewWorkoutButton: UIButton!
    @IBOutlet weak var workoutsTableView: UITableView!
    
    // MARK: - Properties
    var runWorkouts: [HKWorkout]?
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        return formatter
    }()
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        authorizeHealthKit()
        fetchWorkouts()
        workoutsTableView.dataSource = self
        workoutsTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUI()
        fetchWorkouts()
    }
    
    // MARK: - Helper Functions
    
    // setup UI
    func setUpUI() {
        startNewWorkoutButton.layer.masksToBounds = true
        startNewWorkoutButton.layer.cornerRadius = 5.0
    }
    
    // authorize HealthKit the first time this view is loaded
    func authorizeHealthKit() {
     
        SetupHealthKit.authorizeHK { (authorized, error) in
            if authorized {
                print("HealthKit successfully authorized.")
                return
            }
            if let error = error {
                print("HealthKit authorization failed.  \(error.localizedDescription)")
                return
            }
        }
    }
    
    // fetch workouts from HealthKit
    func fetchWorkouts() {
        WorkoutController.shared.loadRunningWorkouts { (workouts, error) in
            self.runWorkouts = workouts
            self.workoutsTableView.reloadData()
        }
    }
    
    // MARK: - Navigation

    // TODO: segue to WorkoutDetailVC from table view cell
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWorkoutDetail" {
            let destinationVC = segue.destination as? WorkoutDetailVC
            guard let indexPath = workoutsTableView.indexPathForSelectedRow else { return }
            let workout = runWorkouts?[indexPath.row]
            destinationVC?.workout = workout
        }
    }

    // MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return runWorkouts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let workouts = runWorkouts else {
            fatalError("No workouts found!")
        }
        let cell = workoutsTableView.dequeueReusableCell(withIdentifier: "workoutCell", for: indexPath)
        let workout = workouts[indexPath.row]
        cell.textLabel?.text = dateFormatter.string(from: workout.startDate)
        cell.detailTextLabel?.text = String(format: "%.01f", workout.duration) + "s"
        return cell
    }
    
    // MARK: - IBAction
    
    @IBAction func settingsButtonTapped(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toFinePrintVC", sender: nil)
    }
}
