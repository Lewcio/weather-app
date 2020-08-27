//
//  Weather.swift
//  Weather
//
//  Created by m.lewandowski on 23/08/2020.
//  Copyright © 2020 michalewandowski.com. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    let city: String
    let summary: [WeatherSummary]
    let details: WeatherDetails
    let clouds: WeatherClouds
    
    enum CodingKeys: String, CodingKey {
        case city = "name"
        case summary = "weather"
        case details = "main"
        case clouds
    }
    
    struct WeatherSummary: Decodable {
        let id: Int
        let title: String
        let description: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case title = "main"
            case description
        }
    }
    
    struct WeatherDetails: Decodable {
        let temperature: Double
        let feelsLike: Double
        let temperatureMin: Double
        let temperatureMax: Double
        
        enum CodingKeys: String, CodingKey {
            case temperature = "temp"
            case feelsLike = "feels_like"
            case temperatureMin = "temp_min"
            case temperatureMax = "temp_max"
        }
    }
    
    struct WeatherClouds: Decodable {
        let percent: Int
        
        enum CodingKeys: String, CodingKey {
            case percent = "all"
        }
    }
}
