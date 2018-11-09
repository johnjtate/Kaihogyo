//
//  WorkoutController.swift
//  Kaihogyo
//
//  Created by John Tate on 11/9/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation
import HealthKit

class WorkoutController {
    
    static let shared = WorkoutController()
    private init() {}
    
    func save(runWorkout: RunningWorkout, completion: @escaping ((Bool, Error?) -> Void)) {
        
        let HKStore = HKHealthStore()
        let workoutConfig = HKWorkoutConfiguration()
        // needs to be modified in future versions to allow other types of workouts
        workoutConfig.activityType = .running
        let workoutBuilder = HKWorkoutBuilder(healthStore: HKStore, configuration: workoutConfig, device: .local())
        
        workoutBuilder.beginCollection(withStart: runWorkout.startTime) { (success, error) in
            guard success else {
                completion(false, error)
                return
            }
        }
        
        // in future versions, insert code here to add samples
        
        workoutBuilder.endCollection(withEnd: runWorkout.endTime) { (success, error) in
            guard success else {
                completion(false, error)
                return
            }
        }
    }

    func loadRunningWorkouts(completion: @escaping ([HKWorkout]?, Error?) -> Void) {
     
        // in future versions, need to extend beyond just running workouts
        let workoutPredicate = HKQuery.predicateForWorkouts(with: .running)
        // workouts from this app as the HKSource
        let sourcePredicate = HKQuery.predicateForObjects(from: .default())
        
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [workoutPredicate, sourcePredicate])
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: true)
        
        let query = HKSampleQuery(sampleType: .workoutType(), predicate: compoundPredicate, limit: 0, sortDescriptors: [sortDescriptor]) { (query, samples, error) in
            
            // have to use main queue
            DispatchQueue.main.async {
                guard let samples = samples as? [HKWorkout], error == nil else {
                    completion(nil, error)
                    return
                }
                
                completion(samples, nil)
            }
        }
        
        HKHealthStore().execute(query)
    }
}
