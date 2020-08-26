//
//  ReusableView.swift
//  Weather
//
//  Created by m.lewandowski on 26/08/2020.
//  Copyright © 2020 michalewandowski.com. All rights reserved.
//

import Foundation

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
