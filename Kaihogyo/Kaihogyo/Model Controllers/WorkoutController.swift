//
//  WorkoutController.swift
//  Kaihogyo
//
//  Created by John Tate on 11/9/18.
//  Copyright © 2018 John Tate. All rights reserved.
//
/**
 * Substantial portion of code adapted from Prancercise Tracker app.  Copyright notice provided below.
 *
 * Copyright (c) 2018 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

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
