//
//  InspirationItemController.swift
//  Kaihogyo
//
//  Created by John Tate on 11/5/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit
import CloudKit

class InspirationItemController {
    
    static let shared = InspirationItemController()
    private init() {}
    
    var inspirationItems = [InspirationItem]()
    
    let privateDB = CKContainer.default().privateCloudDatabase
    
    // MARK: - Create InspirationItem
    func createInspirationItemWith(caption: String, image: UIImage, completion: @escaping (InspirationItem?) -> Void) {
        
        let item = InspirationItem(caption: caption, image: image)
        self.inspirationItems.append(item)
        privateDB.save(CKRecord(item)) { (_, error) in
            if let error = error {
                print("Error saving inspiration item record \(error) \(error.localizedDescription)")
                completion(nil)
                return
            }
            completion(item)
        }
    }
    
    func save(inspirationItem: InspirationItem, completion: @escaping (Bool) -> ()) {
        
        let itemRecord = CKRecord(inspirationItem)
        CKContainer.default().privateCloudDatabase.save(itemRecord) { (record, error) in
            
            if let error = error {
                print(" There was an error in \(#function) ; \(error) ; \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let record = record, let item = InspirationItem(record: record) else {
                completion(false)
                return
            }
            self.inspirationItems.append(item)
            completion(true)
        }
    }
    
    func updateEntry(item: InspirationItem, caption: String, image: UIImage, completion: @escaping (Bool) -> Void) {
        
        var imageAsset: Data?
        
        // update the local item
        item.caption = caption
        item.image = image
        
        // update the item's remote record in CloudKit
        privateDB.fetch(withRecordID: item.recordID) { (record, error) in
            if let error = error {
                print("\(error.localizedDescription) \(error) in function: \(#function)")
                completion(false)
                return
            }

            guard let record = record else {
                completion(false)
                return
            }
            
            record[Constants.captionKey] = caption
            // convert the image to data
            imageAsset = image.jpegData(compressionQuality: 0.1)
            record[Constants.imageDataKey] = imageAsset
            
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
        privateDB.delete(withRecordID: item.recordID) { (_, error) in
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
        let query = CKQuery(recordType: Constants.recordTypeKey, predicate: predicate)
        
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
            let items = records.compactMap{ InspirationItem(record: $0) }
            self.inspirationItems = items
            completion(true)
        }
    }
}
