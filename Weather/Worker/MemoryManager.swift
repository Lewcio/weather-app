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
    func saveCity(city: String)
}

class MemoryManager: MemoryManagerProtocol {
    
    let defaults = UserDefaults.standard
    
    func getSavedCities() -> Observable<[SavedLocation]> {
        let cities = defaults.array(forKey: "SavedCities") as? [SavedLocation] ?? [SavedLocation]()
        return Observable.just(cities)
    }
    
    
    func saveCity(city: String) {
        var cities = defaults.array(forKey: "SavedCities") as? [SavedLocation] ?? [SavedLocation]()
        cities.append(SavedLocation(city: city))
        defaults.set(cities, forKey: "SavedCities")
    }
}
