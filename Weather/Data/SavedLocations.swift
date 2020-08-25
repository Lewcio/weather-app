//
//  Memory.swift
//  Weather
//
//  Created by m.lewandowski on 24/08/2020.
//  Copyright © 2020 michalewandowski.com. All rights reserved.
//

import Foundation

protocol MemoryProtocol {
    func getSavedLocations() -> [Location]
}

class Memory: MemoryProtocol {
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
}
