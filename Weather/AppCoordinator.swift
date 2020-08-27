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
            viewController.router = unownedRouter
            return .push(viewController)
        case .addLocation:
            let viewController = AddLocationViewController()
            let interactor = AddLocationInteractor(memoryManager: MemoryManager())
            let presenter = AddLocationPresenter(interactor: interactor)
            viewController.presenter = presenter
            viewController.modalPresentationStyle = .pageSheet
            return .present(viewController)
        }
    }
}
