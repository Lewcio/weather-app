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
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        label.textColor = .white
       
        return label
   }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        
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
    
    func setupView(viewModel: WeatherViewModel) {
        view.backgroundColor = .veryDark
        view.layer.cornerRadius = 10
        weatherIconView.image = viewModel.icon
        let temperatureString = String(format: "%.0f", viewModel.temperature)
        temperatureLabel.text = "\(temperatureString) ℃"
        locationLabel.text = viewModel.city
    }
    
    private func setupSubviews() {
        view.addSubview(weatherIconView)
        view.addSubview(locationLabel)
        view.addSubview(temperatureLabel)
    }
    
    private func setupConstraints() {
        weatherIconView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(Constants.Margin.leading)
            $0.size.equalTo(Constants.WeatherIconView.size)
        }
        
        locationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.LocationLabel.top)
            $0.leading.equalTo(weatherIconView.snp.trailing).offset(Constants.Margin.leading)
            $0.trailing.equalToSuperview().offset(Constants.Margin.trailing)
            $0.height.equalTo(Constants.LocationLabel.height)
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom).offset(Constants.TemperatureLabel.top)
            $0.leading.equalTo(weatherIconView.snp.trailing).offset(Constants.Margin.leading)
            $0.trailing.equalToSuperview().offset(Constants.Margin.trailing)
            $0.bottom.equalToSuperview().offset(Constants.TemperatureLabel.bottom)
        }
    }
}

private extension LocationViewCell {
    struct Constants {
        struct WeatherIconView {
            static let size: CGFloat = 40
        }
        
        struct TemperatureLabel {
            static let top: CGFloat = 10
            static let bottom: CGFloat = -20
        }
        
        struct LocationLabel {
            static let top: CGFloat = 20
            static let height: CGFloat = 24
        }
        
        struct Margin {
            static let leading: CGFloat = 20
            static let trailing: CGFloat = -20
        }
    }
}
