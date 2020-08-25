//
//  DetailsPresenter.swift
//  Weather
//
//  Created by m.lewandowski on 23/08/2020.
//  Copyright © 2020 michalewandowski.com. All rights reserved.
//

import RxSwift
import RxCocoa

final class DetailsPresenter: DetailsPresenterProtocol {

    // MARK: - Inputs

    let viewDidLoadTrigger = PublishRelay<Void>()
    let viewWillAppearTrigger = PublishRelay<Void>()
    let viewWillDisappearTrigger = PublishRelay<Void>()

    // MARK: - Outputs

    // MARK: - Attributes

    private let interactor: DetailsInteractorProtocol
    weak var coordinator: DetailsCoordinatorDelegate?

    private let disposeBag = DisposeBag()

    // MARK: - Functions

    init(interactor: DetailsInteractorProtocol) {
        self.interactor = interactor
        inputs.viewDidLoadTrigger.subscribe(onNext: { [weak self] in
            self?.viewDidLoad()
        }).disposed(by: disposeBag)
    }
}

private extension DetailsPresenter {
    
    func viewDidLoad() {
        // setup rx binding make first WS calls etc.
    }
}
