//
//  DashboardStackViewGenerator.swift
//  Weather
//
//  Created by m.lewandowski on 02/09/2020.
//  Copyright © 2020 michalewandowski.com. All rights reserved.
//

import UIKit

class DashboardStackViewGenerator {
    static func currentLocation(viewModel: WeatherViewModel?) -> [UIView] {
        if let viewModel = viewModel {
            let image = UIImageView(image: viewModel.icon)
            image.snp.makeConstraints { $0.size.equalTo(Constants.WeatherIcon.size) }

            let temperatureLabel = UILabel()
            let temperatureString = String(format: "%.1f", viewModel.temperature)
            temperatureLabel.font = .systemFont(ofSize: Constants.TemperatureLabel.fontSize, weight: .heavy)
            temperatureLabel.textColor = .white
            temperatureLabel.text = "\(temperatureString) ℃"

            let cityLabel = UILabel()
            cityLabel.font = .systemFont(ofSize: Constants.CityLabel.fontSize, weight: .semibold)
            cityLabel.textColor = .white
            cityLabel.text = viewModel.city
            
            return [image, temperatureLabel, cityLabel]
        } else {
            let noLocationTitleLabel = UILabel()
            noLocationTitleLabel.text = "Location services are disabled"
            noLocationTitleLabel.font = .systemFont(ofSize: 15, weight: .medium)
            noLocationTitleLabel.textColor = .white
            
            let noLocationSubitleLabel = UILabel()
            noLocationSubitleLabel.font = .systemFont(ofSize: 12, weight: .light)
            noLocationSubitleLabel.text = "· Go to Settings ➤ Privacy ➤ Location\n· Enable location for Weather app"
            noLocationSubitleLabel.numberOfLines = 0
            noLocationSubitleLabel.textColor = .white
            
            return [noLocationTitleLabel, noLocationSubitleLabel]
        }
    }
}


private extension DashboardStackViewGenerator {
    struct Constants {
        
        struct TemperatureLabel {
            static let fontSize: CGFloat = 36
        }
        
        struct WeatherIcon {
            static let size: CGFloat = 60
        }
        
        struct CityLabel {
            static let fontSize: CGFloat = 17
        }
    }
}
