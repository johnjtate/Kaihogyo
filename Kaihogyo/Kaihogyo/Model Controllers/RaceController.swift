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
    
    func fetchRaces(completion: @escaping([Race]?) -> Void) {
    
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
        // default value is F (false)
        let only_races_with_results = URLQueryItem(name: "only_races_with_results", value: "T")
        //TODO: don't want to hardcode this; probably needs to be called in by the function
        let state = URLQueryItem(name: "state", value: "UT")
        let min_distance = URLQueryItem(name: "min_distance", value: "13")
        // default value is K (kilometers)
        let distance_units = URLQueryItem(name: "distance_units", value: "M")
        // APIkey and APIsecret stored in APIkeys.plist
        let apiKey = APIkeys.shared.RunSignUpAPIKey()
        let api_key = URLQueryItem(name: "api_key", value: apiKey)
        let apiSecret = APIkeys.shared.RunSignUpAPISecret()
        let api_secret = URLQueryItem(name: "api_secret", value: apiSecret)
    
        components?.queryItems = [format, events, race_headings, race_links, include_waiver, include_event_days, page, results_per_page, sort, start_date, only_partner_races, search_start_date_only, only_races_with_results, state, min_distance, distance_units, api_key, api_secret]
        
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
