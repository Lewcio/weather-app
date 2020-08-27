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
    
    func saveLocation(city: String) {
        interactor.saveLocation(city: city)
    }

    // MARK: - Attributes

    private let interactor: AddLocationInteractorProtocol

    private let disposeBag = DisposeBag()

    // MARK: - Functions

    init(interactor: AddLocationInteractorProtocol) {
        self.interactor = interactor
    }
}
