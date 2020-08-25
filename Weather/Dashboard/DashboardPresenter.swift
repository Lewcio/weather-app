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
    let viewWillAppearTrigger = PublishRelay<Void>()
    let viewWillDisappearTrigger = PublishRelay<Void>()

    // MARK: - Outputs

    // MARK: - Attributes

    private let interactor: DashboardInteractorProtocol
    weak var coordinator: DashboardCoordinatorDelegate?

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
        // setup rx binding make first WS calls etc.
    }
}
