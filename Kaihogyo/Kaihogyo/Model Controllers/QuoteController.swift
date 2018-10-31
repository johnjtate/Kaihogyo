//
//  QuoteController.swift
//  Kaihogyo
//
//  Created by John Tate on 10/30/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation
import CoreData

class QuoteController {
    
    static let sharedController = QuoteController()
    
    func add(quote: Quote) {
        saveToPersistentStorage()
    }
    
    func remove(quote: Quote) {
        quote.managedObjectContext?.delete(quote)
        saveToPersistentStorage()
    }
    
    func saveToPersistentStorage() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("Error saving Managed Object Context.  Items not saved.")
        }
    }
}

