//
//  UserController.swift
//  Kaihogyo
//
//  Created by John Tate on 10/31/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation
import CloudKit

class UserController {
    
    // shared instance
    static let shared = UserController()
    private init() {}
    
    let currentUserWasSetNotification = Notification.Name("currentUserSet")
    
    // currentUser made optional because may not be logged in yet
    var currentUser: User?
    
    // CRUD functions
    func createUserWith(username: String, email: String, completion: ((Bool) -> Void)?) {
        
        CKContainer.default().fetchUserRecordID { (recordID, error) in
            if let error = error {
                print("There was an error in \(#function) : \(error) \(error.localizedDescription)")
                completion?(false)
                return
            }
            
            guard let recordID = recordID else { completion?(false); return }
            //TODO: remove this--don't want to delete a user if disconnects from iCloud?
            let appleUserRef = CKRecord.Reference(recordID: recordID, action: .deleteSelf)
            // creating a record locally, so don't have a recordID yet and it will be created by default
            let user = User(username: username, email: email, appleUserRef: appleUserRef)
            // use the extension to create a CKRecord for the user
            let userRecord = CKRecord(user: user)
            
            //TODO: make sure we want to use the private database here
            CKContainer.default().privateCloudDatabase.save(userRecord, completionHandler: { (record, error) in
                
                if let error = error {
                    print("There was an error in \(#function) : \(error) \(error.localizedDescription)")
                    completion?(false)
                    return
                }
                
                // if a record is returned by the completion, the save function to CloudKit worked
                guard let record = record, let user = User(cloudKitRecord: record) else { completion?(false); return }
                
                // set the currentUser equal to the user
                self.currentUser = user
                completion?(true)
            })
        }
    }
    
    func fetchCurrentUser(completion: @escaping (Bool) -> Void) {
        
        // fetch current iCloud account
        CKContainer.default().fetchUserRecordID { (appleUserRecordID, error) in
            
            if let error = error {
                print("There was an error in \(#function) : \(error) \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let appleUserRecordID = appleUserRecordID else { completion(false); return }
            let appleUserReference = CKRecord.Reference(recordID: appleUserRecordID, action: .deleteSelf)
            
            let predicate = NSPredicate(format: "%K == %@", Constants.appleUserRefKey, appleUserReference)
            let query = CKQuery(recordType: Constants.UserRecordType, predicate: predicate)
            
            CKContainer.default().privateCloudDatabase.perform(query, inZoneWith: nil, completionHandler: { (records, error) in
                
                if let error = error {
                    print("There was an error in \(#function) : \(error) \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                guard let record = records?.first else { completion(false); return }
                let user = User(cloudKitRecord: record)
                
                self.currentUser = user
                completion(true)
            })
        }
    }
}
