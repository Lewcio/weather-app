//
//  DashboardInterface.swift
//  Weather
//
//  Created by m.lewandowski on 23/08/2020.
//  Copyright © 2020 michalewandowski.com. All rights reserved.
//

import RxSwift
import RxCocoa

protocol DashboardInteractorProtocol: AnyObject {
    func getWeatherForSavedLocations() -> Observable<[Weather]>
    func getWeatherForCurrentLocation() -> Observable<Weather?>
}

protocol DashboardPresenterInputsProtocol: AnyObject {
    var viewDidLoadTrigger: PublishRelay<Void> { get }
}

protocol DashboardPresenterOutputsProtocol: AnyObject {
    var currentLocWeather: Observable<WeatherViewModel?> { get }
    var savedLocWeather: Driver<[WeatherViewModel]> { get }
}

protocol DashboardPresenterProtocol: DashboardPresenterInputsProtocol, DashboardPresenterOutputsProtocol {
    var inputs: DashboardPresenterInputsProtocol { get }
    var outputs: DashboardPresenterOutputsProtocol { get }
}

extension DashboardPresenterProtocol where Self: DashboardPresenterInputsProtocol & DashboardPresenterOutputsProtocol {
    var inputs: DashboardPresenterInputsProtocol { return self }
    var outputs: DashboardPresenterOutputsProtocol { return self }
}
