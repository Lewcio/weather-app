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
    
    
    func getWeather(for city: String) -> Observable<Weather> {
        let url = "api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(openWeatherApiKey)&lang=pl&units=metric"
        
        return Observable<Weather>.create { observer in
            let request = AF.request(url).validate().responseDecodable(of: Weather.self) { (response) in
                guard let weather = response.value else { return }
                
                observer.onNext(weather)
            }
            
            return Disposables.create {
                request.cancel()
            }
        }.observeOn(MainScheduler.instance)
    }
    
    func getWeather(for loc: Location) -> Observable<Weather?> {
        let url = "api.openweathermap.org/data/2.5/weather?lat=\(loc.latitude)&lon=\(loc.longitude)&appid=\(openWeatherApiKey)&lang=pl&units=metric"
        
        return Observable<Weather?>.create { observer in
            let request = AF.request(url).validate().responseDecodable(of: Weather.self) { (response) in
                guard let weather = response.value else { return }
                
                observer.onNext(weather)
            }
            
            return Disposables.create {
                request.cancel()
            }
        }.observeOn(MainScheduler.instance)
    }
}
