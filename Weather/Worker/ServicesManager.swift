//
//  ServicesManager.swift
//  Weather
//
//  Created by m.lewandowski on 23/08/2020.
//  Copyright © 2020 michalewandowski.com. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

protocol ServiceManagerProtocol {
    func getWeather(for: String) -> Observable<Weather>
    func getWeather(for: Location) -> Observable<Weather?>
}

class ServiceManager: ServiceManagerProtocol {
    let openWeatherApiKey = "25ddb8c40ea6098cef3f11cf12f43bec"
    
    
    func getWeather(for: String) -> Observable<Weather> {
        return Observable.just(Weather())
    }
    
    func getWeather(for: Location) -> Observable<Weather?> {
        return Observable.just(Weather())
    }
}
