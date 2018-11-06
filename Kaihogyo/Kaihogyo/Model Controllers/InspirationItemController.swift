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
    
    
    
    
    
}
