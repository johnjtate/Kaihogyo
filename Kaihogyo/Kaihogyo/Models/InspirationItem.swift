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
    static let recordTypeKey = "InspirationItem"
    static let captionKey = "caption"
    static let imageDataKey = "imageData"
}

class InspirationItem {
    
    var recordID = CKRecord.ID(recordName: UUID().uuidString)
    var caption: String
    var imageData: Data?
    var tempURL: URL?
    
    init(caption: String, image: UIImage) {
        self.caption = caption
        self.image = image
    }
    
    // computed property to create UIImage from data
    var image: UIImage? {
        get {
            guard let imageData = imageData else { return nil }
            return UIImage(data: imageData)
        }
        set {
            imageData = newValue?.jpegData(compressionQuality: 0.4)
        }
    }
    
    // computed property for image storage as CKAsset
    var imageAsset: CKAsset? {
        get {
            let tempDirectory = NSTemporaryDirectory()
            let tempDirectoryURL = URL(fileURLWithPath: tempDirectory)
            let fileURL = tempDirectoryURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("jpg")
            self.tempURL = fileURL
            do {
                try imageData?.write(to: fileURL)
            } catch let error {
                print("Error writing image asset to temporary URL \(error) \(error.localizedDescription)")
            }
            return CKAsset(fileURL: fileURL)
        }
    }
    
    // deinitializer for temporary file manager storage for image asset
    deinit {
        if let url = tempURL {
            do {
                try FileManager.default.removeItem(at: url)
            } catch let error {
                print("Error deleting temp file, or may cause memory leak: \(error)")
            }
        }
    }

    // MARK: - Fetching the CKRecord and CKAsset
    // failable initializer to create an InspirationItem from a CKRecord
    init?(record: CKRecord) {
        guard let caption = record[Constants.captionKey] as? String,
            let imageAsset = record[Constants.imageDataKey] as? CKAsset else { return nil }
        guard let imageData = try? Data(contentsOf: imageAsset.fileURL) else { return nil }
        
        self.caption = caption
        self.imageData = imageData
        self.recordID = record.recordID
    }
}

// convenience init to create a CKRecord from an InspirationItem
extension CKRecord {
    convenience init(_ item: InspirationItem) {
        self.init(recordType: Constants.recordTypeKey, recordID: item.recordID)
        self.setValue(item.caption, forKey: Constants.captionKey)
        self.setValue(item.imageAsset, forKey: Constants.imageDataKey)
    }
}

extension InspirationItem: Equatable {
    static func ==(lhs: InspirationItem, rhs: InspirationItem) -> Bool {
        return lhs.caption == rhs.caption && lhs.imageData == rhs.imageData
    }
}



