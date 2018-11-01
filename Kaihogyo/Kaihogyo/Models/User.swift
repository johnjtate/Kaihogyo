//
//  User.swift
//  Kaihogyo
//
//  Created by John Tate on 10/31/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation
import CloudKit

class User {
    
    var cloudKitRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)
    let appleUserReference: CKRecord.Reference
    
    init(ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), appleUserRef: CKRecord.Reference) {
        
        self.cloudKitRecordID = ckRecordID
        self.appleUserReference = appleUserRef
    }
    // creates a CKRecord from a user
    convenience init?(cloudKitRecord: CKRecord) {
        
        // 1) unwrap all the necessary values
        guard let appleUserReference = cloudKitRecord[Constants.appleUserRefKey] as? CKRecord.Reference else { return nil }
        
        // 2) initialize the actual object
        self.init(ckRecordID: cloudKitRecord.recordID, appleUserRef: appleUserReference)
    }
}

extension CKRecord {
    // creates a user from a CKRecord
    convenience init(user: User) {
        
        let recordID = user.cloudKitRecordID
        self.init(recordType: Constants.UserRecordType, recordID: recordID)
        self.setValue(user.appleUserReference, forKey: Constants.appleUserRefKey)
    }
}

struct Constants {
    
    static let UserRecordType = "User"
    // no key needed for recordID
    static let appleUserRefKey = "AppleUserReference"
}
