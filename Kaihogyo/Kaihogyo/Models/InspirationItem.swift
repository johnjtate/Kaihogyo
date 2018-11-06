//
//  InspirationItem.swift
//  Kaihogyo
//
//  Created by John Tate on 11/5/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit
import CloudKit

struct Constants {
    static let recordKey = "InspirationItem"
    static let textKey = "Text"
    static let imageKey = "Photo"
}


class InspirationItem {
    
    var text: String?
    var imageData: Data?
    var ckRecordID: CKRecord.ID
    
    init(text: String?, imageData: Data?, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.text = text
        self.imageData = imageData
        self.ckRecordID = ckRecordID
    }

    convenience init?(ckRecord: CKRecord) {
        
        guard let text = ckRecord[Constants.textKey] as? String,
            let imageData = ckRecord[Constants.imageKey] as? Data else { return nil }
        
        self.init(text: text, imageData: imageData, ckRecordID: ckRecord.recordID)
    }
}

extension InspirationItem: Equatable {
    static func ==(lhs: InspirationItem, rhs: InspirationItem) -> Bool {
        return lhs.text == rhs.text && lhs.imageData == rhs.imageData
    }
}

extension CKRecord {
    
    convenience init(inspirationItem: InspirationItem) {
        
        self.init(recordType: Constants.recordKey, recordID: inspirationItem.ckRecordID)
        
        self.setValue(inspirationItem.text, forKey: Constants.textKey)
        self.setValue(inspirationItem.imageData, forKey: Constants.imageKey)
    }
}
