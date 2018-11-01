//
//  Race.swift
//  Kaihogyo
//
//  Created by John Tate on 10/31/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation

struct JsonDictionary: Decodable {
    
    let races: [Race]
    
    private enum CodingKeys: String, CodingKey {
        case races
    }
}

struct Race: Decodable {
    
    let race: RaceDictionary
    
    struct RaceDictionary: Decodable {
        
        let name: String
        let date: String
        let race_id: Int
        
        private enum CodingKeys: String, CodingKey {
            case name
            case date = "next_date"
            case race_id
        }
    }
    
}
