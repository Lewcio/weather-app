//
//  UICollectionView.swift
//  Weather
//
//  Created by m.lewandowski on 26/08/2020.
//  Copyright © 2020 michalewandowski.com. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
    }
}
