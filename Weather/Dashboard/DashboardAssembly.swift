//
//  DashboardAssembly.swift
//  Weather
//
//  Created by m.lewandowski on 23/08/2020.
//  Copyright © 2020 michalewandowski.com. All rights reserved.
//

import Foundation
import Swinject

class DashboardAssembly: Assembly {
    func assemble(container: Container) {
        
        container.register(Memory.self) { r in
            Memory(userDefaults: r.resolve(UserDefaults.self)!)
        }
        
        container.register(AddLocationViewController.self) { (resolver, coordinator: AddLocationCoordinatorDelegate) in
            let viewController = AddLocationViewController()
            let interactor = AddLocationInteractor()
            let presenter = AddLocationPresenter(interactor: interactor)
            presenter.coordinator = coordinator
            viewController.presenter = presenter
            return viewController
        }
        
        container.register(DashboardViewController.self) { (resolver, coordinator: DashboardCoordinatorDelegate) in
            let viewController = DashboardViewController()
            let interactor = DashboardInteractor()
            let presenter = DashboardPresenter(interactor: interactor)
            presenter.coordinator = coordinator
            viewController.presenter = presenter
            return viewController
        }
        
        container.register(DetailsViewController.self) { (resolver, coordinator: DetailsCoordinatorDelegate) in
            let viewController = DetailsViewController()
            let interactor = DetailsInteractor()
            let presenter = DetailsPresenter(interactor: interactor)
            presenter.coordinator = coordinator
            viewController.presenter = presenter
            return viewController
        }
    }
}
