//
//  APIkeys.swift
//  Kaihogyo
//
//  Created by John Tate on 11/1/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation

struct APIkeys {
    
    static let shared = APIkeys()
    private init() {}
    
    func RunSignUpAPIKey() -> String {
        let filePath = Bundle.main.path(forResource: "APIkeys", ofType: "plist")
        let plist = NSDictionary(contentsOfFile: filePath!)
        let value = plist?.object(forKey: "RunSIgnUpAPIKey") as! String
        return value
    }
    
    func RunSignUpAPISecret() -> String {
        let filePath = Bundle.main.path(forResource: "APIkeys", ofType: "plist")
        let plist = NSDictionary(contentsOfFile: filePath!)
        let value = plist?.object(forKey: "RunSignUpAPISecret") as! String
        return value
    }
}
