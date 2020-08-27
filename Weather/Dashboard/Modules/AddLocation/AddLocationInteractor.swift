//
//  AddLocationInteractor.swift
//  Weather
//
//  Created by m.lewandowski on 23/08/2020.
//  Copyright © 2020 michalewandowski.com. All rights reserved.
//

import RxSwift

final class AddLocationInteractor: AddLocationInteractorProtocol {
    
    private let memoryManager: MemoryManagerProtocol
    
    init(memoryManager: MemoryManagerProtocol) {
        self.memoryManager = memoryManager
    }
    
    func saveLocation(city: String) {
        memoryManager.saveLocation(city: city)
    }
    

}
