//
//  AddLocationPresenter.swift
//  Weather
//
//  Created by m.lewandowski on 23/08/2020.
//  Copyright © 2020 michalewandowski.com. All rights reserved.
//

import RxSwift
import RxCocoa

final class AddLocationPresenter: AddLocationPresenterProtocol {

    // MARK: - Inputs

    let viewDidLoadTrigger = PublishRelay<Void>()
    let viewWillAppearTrigger = PublishRelay<Void>()
    let viewWillDisappearTrigger = PublishRelay<Void>()
    
    func saveLocation(city: String) {
        interactor.saveLocation(city: city)
    }

    // MARK: - Outputs

    // MARK: - Attributes

    private let interactor: AddLocationInteractorProtocol
    weak var coordinator: AddLocationCoordinatorDelegate?

    private let disposeBag = DisposeBag()

    // MARK: - Functions

    init(interactor: AddLocationInteractorProtocol) {
        self.interactor = interactor
        inputs.viewDidLoadTrigger.subscribe(onNext: { [weak self] in
            self?.viewDidLoad()
        }).disposed(by: disposeBag)
    }
}

private extension AddLocationPresenter {
    
    func viewDidLoad() {
        // setup rx binding make first WS calls etc.
    }
}
