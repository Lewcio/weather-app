//
//  MemoryManager.swift
//  Weather
//
//  Created by m.lewandowski on 26/08/2020.
//  Copyright © 2020 michalewandowski.com. All rights reserved.
//

import Foundation
import RxSwift

protocol MemoryManagerProtocol {
    func getSavedCities() -> Observable<[SavedLocation]>
    func saveLocation(city: String)
}

class MemoryManager: MemoryManagerProtocol {
    
    let defaults = UserDefaults.standard
    
    func getSavedCities() -> Observable<[SavedLocation]> {
        let cities = defaults.array(forKey: "SavedCities") as? [String] ?? [String]()
        var savedLocation = [SavedLocation]()
        cities.forEach { savedLocation.append(SavedLocation(city: $0))}
        return Observable.just(savedLocation)
    }
    
    
    func saveLocation(city: String) {
        let formattedCity = city.lowercased()
        var cities = defaults.array(forKey: "SavedCities") as? [String] ?? [String]()
        
        guard !cities.contains(formattedCity) else { return }
        
        cities.append(formattedCity)
        defaults.set(cities, forKey: "SavedCities")
    }
}
