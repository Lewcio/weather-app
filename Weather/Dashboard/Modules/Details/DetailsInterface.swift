//
//  DetailsInterface.swift
//  Weather
//
//  Created by m.lewandowski on 23/08/2020.
//  Copyright © 2020 michalewandowski.com. All rights reserved.
//

import RxSwift
import RxCocoa

protocol DetailsInteractorProtocol: AnyObject {
}

protocol DetailsCoordinatorDelegate: AnyObject {
}

protocol DetailsPresenterInputsProtocol: AnyObject {
    var viewDidLoadTrigger: PublishRelay<Void> { get }
    var viewWillAppearTrigger: PublishRelay<Void> { get }
    var viewWillDisappearTrigger: PublishRelay<Void> { get }
}

protocol DetailsPresenterOutputsProtocol: AnyObject {
}

protocol DetailsPresenterProtocol: DetailsPresenterInputsProtocol, DetailsPresenterOutputsProtocol {
    var inputs: DetailsPresenterInputsProtocol { get }
    var outputs: DetailsPresenterOutputsProtocol { get }
}

extension DetailsPresenterProtocol where Self: DetailsPresenterInputsProtocol & DetailsPresenterOutputsProtocol {
    var inputs: DetailsPresenterInputsProtocol { return self }
    var outputs: DetailsPresenterOutputsProtocol { return self }
}
