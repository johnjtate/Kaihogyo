//
//  SetupHealthKit.swift
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

class SetupHealthKit {
    private enum HKSetupError: Error {
        // example: device is an iPad, so HealthKit not available
        case notAvailableOnDevice
        case dataTypeNotAvailable
    }
    
    class func authorizeHK(completion: @escaping (Bool, Error?) -> Void) {
        
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, HKSetupError.notAvailableOnDevice)
            return
        }
        
        let HKTypesToWrite: Set<HKSampleType> = [HKObjectType.workoutType()]
        let HKTypesToRead: Set<HKObjectType> = [HKObjectType.workoutType()]
        
        HKHealthStore().requestAuthorization(toShare: HKTypesToWrite, read: HKTypesToRead) { (success, error) in
            
            completion(success, error)
        }
    }
}
