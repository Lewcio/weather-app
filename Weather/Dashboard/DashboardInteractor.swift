//
//  DashboardInteractor.swift
//  Weather
//
//  Created by m.lewandowski on 23/08/2020.
//  Copyright © 2020 michalewandowski.com. All rights reserved.
//

import RxSwift

final class DashboardInteractor: DashboardInteractorProtocol {
    
    private let serviceManager: ServiceManagerProtocol
    private let locationManager: LocationManagerProtocol
    private let memoryManager: MemoryManagerProtocol
    
    init(serviceManager: ServiceManagerProtocol, locationManager: LocationManagerProtocol, memoryManager: MemoryManagerProtocol) {
        self.serviceManager = serviceManager
        self.locationManager = locationManager
        self.memoryManager = memoryManager
    }
    
    func getWeatherForLocation(city: String) -> Observable<Weather> {
        memoryManager.getSavedCities().map { (location) -> [SavedLocation] in
            return location
        }
        return serviceManager.getWeather(for: city)
    }
    
    func getWeatherForCurrentLocation() -> Observable<Weather?> {
        guard let location = locationManager.getCurrentLocation else { return Observable.just(nil) }
        
        return serviceManager.getWeather(for: location)
    }
}
