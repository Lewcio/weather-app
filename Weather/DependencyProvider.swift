//
//  DependencyProvider.swift
//  Weather
//
//  Created by m.lewandowski on 25/08/2020.
//  Copyright © 2020 michalewandowski.com. All rights reserved.
//

import Foundation
import Swinject

class DependencyProvider {
    
    let container = Container()
    let assembler: Assembler
    
    init() {
        assembler = Assembler(
            [
                DashboardAssembly()
            ], container: container
        )
    }
}
