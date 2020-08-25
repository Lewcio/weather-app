//
//  ServicesManager.swift
//  Weather
//
//  Created by m.lewandowski on 23/08/2020.
//  Copyright © 2020 michalewandowski.com. All rights reserved.
//

import Foundation
import Alamofire

protocol ServicesManagerProtocol {
    func getWeather(for: String) -> Weather
}

class ServiceManager: ServicesManagerProtocol {
    let openWeatherApiKey = "25ddb8c40ea6098cef3f11cf12f43bec"
    
    
    func getWeather(for: String) -> Weather {
        return Weather()
    }
}
