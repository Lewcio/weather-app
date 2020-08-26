//
//  LocationViewCell.swift
//  Weather
//
//  Created by m.lewandowski on 25/08/2020.
//  Copyright © 2020 michalewandowski.com. All rights reserved.
//

import UIKit

class LocationViewCell: UICollectionViewCell {
    
    private let weatherIconView = UIImageView()
    
    private let temperatureLabel: UILabel = {
       let label = UILabel()
       
       return label
   }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(weather: Weather) {
        
    }
    
    func setupSubviews() {
        view.addSubview(weatherIconView)
        view.addSubview(temperatureLabel)
        view.addSubview(locationLabel)
    }
    
    func setupConstraints() {
        weatherIconView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.WeatherIconView.top)
            $0.leading.equalToSuperview().offset(Constants.Margin.leading)
            $0.size.equalTo(Constants.WeatherIconView.size)
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.centerX.equalTo(weatherIconView)
            $0.leading.equalTo(weatherIconView.snp.trailing).offset(Constants.TemperatureLabel.leading)
            $0.leading.equalToSuperview().offset(Constants.Margin.trailing)
        }
        
        locationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.LocationLabel.top)
            $0.leading.equalToSuperview().offset(Constants.Margin.leading)
            $0.trailing.equalToSuperview().offset(Constants.Margin.trailing)
            $0.bottom.equalToSuperview().offset(Constants.LocationLabel.bottom)
        }
    }
}

private extension LocationViewCell {
    struct Constants {
        struct WeatherIconView {
            static let top: CGFloat = 10
            static let size: CGFloat = 80
        }
        
        struct TemperatureLabel {
            static let leading: CGFloat = 10
        }
        
        struct LocationLabel {
            static let top: CGFloat = 10
            static let bottom: CGFloat = -20
        }
        
        struct Margin {
            static let leading: CGFloat = 20
            static let trailing: CGFloat = -20
        }
    }
}
