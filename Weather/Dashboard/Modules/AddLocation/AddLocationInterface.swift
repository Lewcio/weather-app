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

protocol AddLocationPresenterInputsProtocol: AnyObject {
    func saveLocation(city: String)
}

protocol AddLocationPresenterProtocol: AddLocationPresenterInputsProtocol {
    var inputs: AddLocationPresenterInputsProtocol { get }
}

extension AddLocationPresenterProtocol where Self: AddLocationPresenterInputsProtocol {
    var inputs: AddLocationPresenterInputsProtocol { return self }
}
