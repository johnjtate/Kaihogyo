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
        
        let name: String?
        let date: String?
        let description: String?
        let url: String?
        let externalURL: String?
        let imageURL: String
        let address: AddressDictionary
        
        private enum CodingKeys: String, CodingKey {
            case name
            case date = "next_date"
            case description
            case url
            case externalURL = "external_race_url"
            case address
            case imageURL = "logo_url"
        }

        struct AddressDictionary: Decodable {
            
            let street: String?
            let city: String?
            let state: String?
            let zipcode: String?
            let country: String?
            
            private enum CodingKeys: String, CodingKey {
                case street
                case city
                case state
                case zipcode
                case country = "country_code"
            }
        }
    }
}


