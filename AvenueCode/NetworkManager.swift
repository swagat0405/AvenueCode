//
//  NetworkManager.swift
//  AvenueCode
//
//  Created by Swagat Mishra on 6/2/18.
//  Copyright © 2018 Swagat Mishra. All rights reserved.
//

import Foundation

class NetworkManager {
    
    typealias completion = () -> Void
    
    var googleMapAPIUrl = "https://maps.googleapis.com/maps/api/geocode/json"
    
    var apiKey = "AIzaSyA2gPnxwgCeGlZfmvrsNnLhK6N0T0V-oxo"
    
    func search(location: String, completionHandler: @escaping ([Location]) -> Void) {
        
        var requestUrl = URLComponents(string: googleMapAPIUrl)!
        requestUrl.queryItems = [
            URLQueryItem(name: "address", value: location),
            URLQueryItem(name: "CAkey", value: apiKey)
        ]
        requestUrl.percentEncodedQuery = requestUrl.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        let request = URLRequest(url: requestUrl.url!)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("Invalid location")
                completionHandler([])
                return
            }
            print(String(data: data!, encoding: .ascii) ?? "no data")
            do {
                let locations = try JSONDecoder().decode(GoogleLocations.self, from: data!)
                print(locations)
                completionHandler(locations.results)
            } catch {
                print(error.localizedDescription)
                completionHandler([])
            }
            }.resume()
    }
}
