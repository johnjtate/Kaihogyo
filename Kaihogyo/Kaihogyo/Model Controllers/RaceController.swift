//
//  RaceController.swift
//  Kaihogyo
//
//  Created by John Tate on 10/31/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation

class RaceController {
    
    static let shared = RaceController()
    static let baseURL = URL(string: "https://runsignup.com/rest/races")
    var races: [Race] = []
    
    func fetchRaces(min_distance: String?, max_distance: String?, distance_units: String, radius: String?, zipcode: String?, city: String?, state: String?, completion: @escaping([Race]?) -> Void) {
        
        // blank out the array
        self.races = []
        
        guard let baseURL = RaceController.baseURL else { return }
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        // URL query items--all default values for the API unless otherwise indicated
        let format = URLQueryItem(name: "format", value: "json")
        let events = URLQueryItem(name: "events", value: "F")
        let race_headings = URLQueryItem(name: "race_headings", value: "F")
        // default value is false (F)
        let race_links = URLQueryItem(name: "race_links", value: "T")
        let include_waiver = URLQueryItem(name: "include_waiver", value: "F")
        let include_event_days = URLQueryItem(name: "include_event_days", value: "F")
        let page = URLQueryItem(name: "page", value: "1")
        let results_per_page = URLQueryItem(name: "results_per_page", value: "50")
        // default value is name+ASC (ascending)
        let sort = URLQueryItem(name: "sort", value: "date+ASC")
        let start_date = URLQueryItem(name: "start_date", value: "today")
        let only_partner_races = URLQueryItem(name: "only_partner_races", value: "F")
        let search_start_date_only = URLQueryItem(name: "search_start_date_only", value: "F")
        let only_races_with_results = URLQueryItem(name: "only_races_with_results", value: "F")

        // APIkey and APIsecret stored in APIkeys.plist
        let apiKey = APIkeys.shared.RunSignUpAPIKey()
        let api_key = URLQueryItem(name: "api_key", value: apiKey)
        let apiSecret = APIkeys.shared.RunSignUpAPISecret()
        let api_secret = URLQueryItem(name: "api_secret", value: apiSecret)
        
        components?.queryItems = [format, events, race_headings, race_links, include_waiver, include_event_days, page, results_per_page, sort, start_date, only_partner_races, search_start_date_only, only_races_with_results, api_key, api_secret]
        
        if let city = city {
            if !city.isEmpty {
                let cityQuery = URLQueryItem(name: "city", value: "\(String(describing: city))")
                components?.queryItems?.append(cityQuery)
            }
        }
        if let state = state {
            if !state.isEmpty {
                let stateQuery = URLQueryItem(name: "state", value: "\(String(describing: state))")
                components?.queryItems?.append(stateQuery)
            }
        }
        
        if let min_distance = min_distance {
            if !min_distance.isEmpty {
                let minDistanceQuery = URLQueryItem(name: "min_distance", value: "\(String(describing: min_distance))")
                components?.queryItems?.append(minDistanceQuery)
            }
        }
        
        if let max_distance = max_distance {
            if !max_distance.isEmpty {
                let maxDistanceQuery = URLQueryItem(name: "max_distance", value: "\(String(describing: max_distance))")
                components?.queryItems?.append(maxDistanceQuery)
            }
        }
        
        let distanceUnitsQuery = URLQueryItem(name: "distance_units", value: "\(distance_units)")
        components?.queryItems?.append(distanceUnitsQuery)
        
        if let zipcode = zipcode {
            if !zipcode.isEmpty {
                let zipcodeQuery = URLQueryItem(name: "zipcode", value: "\(String(describing: zipcode))")
                components?.queryItems?.append(zipcodeQuery)
            }
        }
        
        if let radius = radius {
            if !radius.isEmpty {
                let radiusQuery = URLQueryItem(name: "radius", value: "\(String(describing: radius))")
                components?.queryItems?.append(radiusQuery)
            }
        }
        
        guard let url = components?.url else { completion([]); return }
        print(url)
    
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            do {
                if let error = error {
                    print("Error with dataTask: \(#function) \(error) \(error.localizedDescription)")
                    completion([]); return
                }
                
                guard let data = data else { completion([]); return }
                
                let racesArray = try JSONDecoder().decode(JsonDictionary.self, from: data).races
                self.races = racesArray
                completion(racesArray)
                
            } catch let error {
                print("Error with JSONDecoder: \(error) \(error.localizedDescription)")
                completion([]); return
            }
        }.resume()
    }
}
