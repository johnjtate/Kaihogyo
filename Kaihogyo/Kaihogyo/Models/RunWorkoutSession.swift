//
//  RunWorkoutSession.swift
//  Kaihogyo
//
//  Created by John Tate on 11/9/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation

enum RunWorkoutStatus {
    case notStarted
    case inProgress
    case completed
}

class RunWorkoutSession {
    var startTime: Date!
    var endTime: Date!
    
    var runningIntervals: [RunningWorkoutInterval] = []
    var workoutState: RunWorkoutStatus = .notStarted
    
    func startRun() {
        startTime = Date()
        workoutState = .inProgress
    }
    
    func endRun() {
        endTime = Date()
        addRunInterval()
        workoutState = .completed
    }
    
    func clearRun() {
        startTime = nil
        endTime = nil
        workoutState = .notStarted
        runningIntervals.removeAll()
    }

    func addRunInterval() {
        let runningInterval = RunningWorkoutInterval(startTime: startTime, endTime: endTime)

        runningIntervals.append(runningInterval)
    }
    
    var completedRunWorkout: RunningWorkout? {
        guard workoutState == .completed, runningIntervals.count > 0 else {
            return nil
        }
        
        return RunningWorkout(with: runningIntervals)
    }
}
