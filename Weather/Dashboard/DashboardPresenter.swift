//
//  DashboardPresenter.swift
//  Weather
//
//  Created by m.lewandowski on 23/08/2020.
//  Copyright © 2020 michalewandowski.com. All rights reserved.
//

import RxSwift
import RxCocoa

final class DashboardPresenter: DashboardPresenterProtocol {

    // MARK: - Inputs

    let viewDidLoadTrigger = PublishRelay<Void>()

    // MARK: - Outputs
    
    var currentLocWeather: Observable<WeatherViewModel?> { return currentLocWeatherRelay.asObservable() }
    var savedLocWeather: Driver<[WeatherViewModel]> { return savedLocWeatherRelay.asDriver() }
    
    private let currentLocWeatherRelay = BehaviorRelay<WeatherViewModel?>(value: nil)
    private let savedLocWeatherRelay = BehaviorRelay<[WeatherViewModel]>(value: [WeatherViewModel]())

    // MARK: - Attributes

    private let interactor: DashboardInteractorProtocol

    private let disposeBag = DisposeBag()

    // MARK: - Functions

    init(interactor: DashboardInteractorProtocol) {
        self.interactor = interactor
        
        inputs.viewDidLoadTrigger.subscribe(onNext: { [weak self] in
            self?.viewDidLoad()
        }).disposed(by: disposeBag)
    }
}

private extension DashboardPresenter {
    
    func viewDidLoad() {
        interactor.getWeatherForCurrentLocation().map { weather -> WeatherViewModel? in
            guard let weather = weather else { return nil }
            return WeatherViewModel(weather)
        }
        .bind(to: currentLocWeatherRelay)
        .disposed(by: disposeBag)
        
        interactor.getWeatherForSavedLocations().map { weather -> [WeatherViewModel] in
            var result = [WeatherViewModel]()
            weather.forEach {
                result.append(WeatherViewModel($0))
            }
            return result
        }
        .bind(to: savedLocWeatherRelay)
        .disposed(by: disposeBag)
    }
}
