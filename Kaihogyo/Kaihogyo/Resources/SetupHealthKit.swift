//
//  SetupHealthKit.swift
//  Kaihogyo
//
//  Created by John Tate on 11/9/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

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
