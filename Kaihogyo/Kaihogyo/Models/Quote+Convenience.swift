//
//  Quote+Convenience.swift
//  Kaihogyo
//
//  Created by John Tate on 10/30/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation
import CoreData

extension Quote {
    
    convenience init(text: String, author: String, url: String?, userAdded: Bool, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.text = text
        self.author = author
        self.url = url
        self.userAdded = userAdded
    }
}
