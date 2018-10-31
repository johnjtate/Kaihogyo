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
    
    var username: String
    var email: String
    
    var cloudKitRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)
    let appleUserReference: CKRecord.Reference
    
    init(username: String, email: String, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), appleUserRef: CKRecord.Reference) {
        
        self.username = username
        self.email = email
        self.cloudKitRecordID = ckRecordID
        self.appleUserReference = appleUserRef
    }
    // creates a CKRecord from a user
    convenience init?(cloudKitRecord: CKRecord) {
        
        // 1) unwrap all the necessary values
        guard let username = cloudKitRecord[Constants.usernameKey] as? String, let email = cloudKitRecord[Constants.emailKey] as? String, let appleUserReference = cloudKitRecord[Constants.appleUserRefKey] as? CKRecord.Reference else { return nil }
        
        // 2) initialize the actual object
        self.init(username: username, email: email, ckRecordID: cloudKitRecord.recordID, appleUserRef: appleUserReference)
    }
}

extension CKRecord {
    // creates a user from a CKRecord
    convenience init(user: User) {
        
        let recordID = user.cloudKitRecordID
        self.init(recordType: Constants.UserRecordType, recordID: recordID)
        self.setValue(user.username, forKey: Constants.usernameKey)
        self.setValue(user.email, forKey: Constants.emailKey)
        self.setValue(user.appleUserReference, forKey: Constants.appleUserRefKey)
    }
}

struct Constants {
    
    static let UserRecordType = "User"
    static let usernameKey = "Username"
    static let emailKey = "Email"
    // no key needed for recordID
    static let appleUserRefKey = "AppleUserReference"
}
