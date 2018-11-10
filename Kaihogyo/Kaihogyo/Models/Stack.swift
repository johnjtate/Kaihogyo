//
//  Stack.swift
//  Kaihogyo
//
//  Created by John Tate on 10/30/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Kaihogyo")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error{
                fatalError("Failed to load from Persistent Store \(error) \(error.localizedDescription)")
            }
        })
        return container
    }()
    
    // direct touchpoint to the context/"sandbox"/larger Source of Truth
    static var context: NSManagedObjectContext { return container.viewContext }
}
