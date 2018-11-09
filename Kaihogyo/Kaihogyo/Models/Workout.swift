//
//  Workout.swift
//  Kaihogyo
//
//  Created by John Tate on 11/9/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation

struct RunningWorkoutInterval {
    var startTime: Date
    var endTime: Date
    
    init(startTime: Date, endTime: Date) {
        self.startTime = startTime
        self.endTime = endTime
    }
    
    var duration: TimeInterval {
        return endTime.timeIntervalSince(startTime)
    }
}

struct RunningWorkout {
    var startTime: Date
    var endTime: Date
    var runningIntervals: [RunningWorkoutInterval]
    var distance: Double
    var comments: String
    
    init(with runningIntervals: [RunningWorkoutInterval]) {
        self.startTime = runningIntervals.first!.startTime
        self.endTime = runningIntervals.last!.endTime
        self.runningIntervals = runningIntervals
        self.distance = 0.0
        self.comments = ""
    }
    
    var duration: TimeInterval {
        return runningIntervals.reduce(0) { (result, runningInterval) in
            result + runningInterval.duration
        }
    }
}
