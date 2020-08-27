//
//  WeatherViewModel.swift
//  Weather
//
//  Created by m.lewandowski on 23/08/2020.
//  Copyright © 2020 michalewandowski.com. All rights reserved.
//

import UIKit
import Rswift

struct WeatherViewModel {
    let city: String
    let temperature: Double
    let icon: UIImage?
    
    init(_ weather: Weather) {
        self.city = weather.city
        self.temperature = weather.details.temperature
        
        if weather.summary.count > 0 {
            switch weather.summary[0].id {
            case ..<300:
                icon = R.image.thunderstorm()
            case ..<500:
                icon = R.image.rain()
            case ..<600:
                icon = R.image.rain()
            case ..<700:
                icon = R.image.snow()
            case ..<800:
                icon = R.image.fog()
            case 800:
                icon = R.image.sunny()
            case ..<804:
                icon = R.image.partlyCloudy()
            case 804:
                icon = R.image.cloudy()
            default:
                icon = nil
            }
        } else {
            icon = nil
        }
    }
}
