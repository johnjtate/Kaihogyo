//
//  Workout.swift
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
