//
//  AddLocationInterface.swift
//  Weather
//
//  Created by m.lewandowski on 23/08/2020.
//  Copyright © 2020 michalewandowski.com. All rights reserved.
//

import RxSwift
import RxCocoa

protocol AddLocationInteractorProtocol: AnyObject {
    func saveLocation(city: String)
}

protocol AddLocationCoordinatorDelegate: AnyObject {
}

protocol AddLocationPresenterInputsProtocol: AnyObject {
    var viewDidLoadTrigger: PublishRelay<Void> { get }
    var viewWillAppearTrigger: PublishRelay<Void> { get }
    var viewWillDisappearTrigger: PublishRelay<Void> { get }
    func saveLocation(city: String)
}

protocol AddLocationPresenterOutputsProtocol: AnyObject {
}

protocol AddLocationPresenterProtocol: AddLocationPresenterInputsProtocol, AddLocationPresenterOutputsProtocol {
    var inputs: AddLocationPresenterInputsProtocol { get }
    var outputs: AddLocationPresenterOutputsProtocol { get }
}

extension AddLocationPresenterProtocol where Self: AddLocationPresenterInputsProtocol & AddLocationPresenterOutputsProtocol {
    var inputs: AddLocationPresenterInputsProtocol { return self }
    var outputs: AddLocationPresenterOutputsProtocol { return self }
}
