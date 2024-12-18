//
//  Creatures.swift
//  Awsome App
//
//  Created by Darrin Jones on 12/18/24.
//

import Foundation

@Observable // Will watch objects for changes so that SwiftUI will redraw the interface when needed
class Creatures {
    private struct Returned: Codable {
        var count: Int
        var next: String // TODO: We want to change this to an optional
        var results: [Result]
    }
    
  struct Result: Codable, Hashable {
        var name: String
        var url: String
    }
    var urlString = "https://pokeapi.co/api/v2/pokemon"
    var count = 0
    var creaturesArray: [Result] = []
   
    func getData() async {
        print ("❄️ We are accessing the url \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            // Try to decode JSON data into our own data structures
            
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("😡 ERROR: Could not decode returned JSON data")
                return
            }
            self.count = returned.count
            self.urlString = returned.next
            self.creaturesArray = returned.results
            
        } catch{
            print(" 😡 ERROR: Could not decode returned JSON data \(urlString)")
        }
    }
}