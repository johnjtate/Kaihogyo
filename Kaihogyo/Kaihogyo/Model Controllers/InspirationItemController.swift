//
//  InspirationItemController.swift
//  Kaihogyo
//
//  Created by John Tate on 11/5/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation
import CloudKit

class InspirationItemController {
    
    static let shared = InspirationItemController()
    private init() {}
    
    var inspirationItems = [InspirationItem]()
    
    let privateDB = CKContainer.default().privateCloudDatabase
    
    func save(inspirationItem: InspirationItem, completion: @escaping (Bool) -> ()) {
        
        let itemRecord = CKRecord(inspirationItem: inspirationItem)
        CKContainer.default().privateCloudDatabase.save(itemRecord) { (record, error) in
            
            if let error = error {
                print(" There was an error in \(#function) ; \(error) ; \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let record = record, let item = InspirationItem(ckRecord: record) else {
                completion(false)
                return
            }
            self.inspirationItems.append(item)
            completion(true)
        }
    }
    
    func addItemWith(text: String?, imageData: Data?, completion: @escaping (Bool) -> Void) {
        let item = InspirationItem(text: text, imageData: imageData)
        self.save(inspirationItem: item) { (success) in
            if success {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func updateEntry(item: InspirationItem, text: String?, imageData: Data?, completion: @escaping (Bool) -> Void) {
        
        // update the local item
        item.text = text
        item.imageData = imageData
        
        // update the item's remote record in CloudKit
        privateDB.fetch(withRecordID: item.ckRecordID) { (record, error) in
            if let error = error {
                print("\(error.localizedDescription) \(error) in function: \(#function)")
                completion(false)
                return
            }

            guard let record = record else {
                completion(false)
                return
            }
            
            record[Constants.textKey] = text
            record[Constants.imageKey] = imageData
            
            let operation = CKModifyRecordsOperation(recordsToSave: [record], recordIDsToDelete: nil)
            operation.savePolicy = .changedKeys
            operation.queuePriority = .high
            operation.qualityOfService = .userInitiated
            operation.modifyRecordsCompletionBlock = { (records, recordIDs, error) in
                completion(true)
            }
            self.privateDB.add(operation)
        }
    }
    
    func deleteItem(item: InspirationItem, completion: @escaping (Bool) -> Void) {
        
        // delete the item locally
        guard let index = InspirationItemController.shared.inspirationItems.index(of: item) else { return }
        InspirationItemController.shared.inspirationItems.remove(at: index)
        
        // delete the item from CloudKit
        privateDB.delete(withRecordID: item.ckRecordID) { (_, error) in
            if let error = error {
                print("\(error.localizedDescription) \(error) in function: \(#function)")
                completion(false)
                return
            } else {
                print("Record deleted from CloudKit")
                completion(true)
            }
        }
    }
    
    func fetchItems(completion: @escaping (Bool) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: Constants.recordKey, predicate: predicate)
        
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("\(error.localizedDescription) \(error) in function: \(#function)")
                completion(false)
                return
            }
            
            guard let records = records else {
                completion(false)
                return
            }
            let items = records.compactMap{ InspirationItem(ckRecord: $0) }
            self.inspirationItems = items
            completion(true)
        }
    }
}
