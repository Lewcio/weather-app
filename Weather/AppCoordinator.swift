//
//  AppCoordinator.swift
//  Weather
//
//  Created by m.lewandowski on 23/08/2020.
//  Copyright © 2020 michalewandowski.com. All rights reserved.
//

import Foundation
import XCoordinator

enum AppRoute: Route {
    case dashboard
    case details
    case addLocation
}

class AppCoordinator: NavigationCoordinator<AppRoute> {
    init() {
        super.init(initialRoute: .dashboard)
    }
    
    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .dashboard:
            let viewController = DashboardViewController()
            let interactor = DashboardInteractor(
                serviceManager: ServiceManager(),
                locationManager: LocationManager(),
                memoryManager: MemoryManager()
            )
            let presenter = DashboardPresenter(interactor: interactor)
            viewController.presenter = presenter
            return .push(viewController)
        case .details:
            let viewController = DetailsViewController()
            let interactor = DetailsInteractor()
            let presenter = DetailsPresenter(interactor: interactor)
            viewController.presenter = presenter
            return .push(viewController)
        case .addLocation:
                let viewController = AddLocationViewController()
            let interactor = AddLocationInteractor()
            let presenter = AddLocationPresenter(interactor: interactor)
            viewController.presenter = presenter
            return .push(viewController)
        }
    }
}
