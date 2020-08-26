//
//  UICollectionView+Reusable.swift
//  Weather
//
//  Created by m.lewandowski on 26/08/2020.
//  Copyright © 2020 michalewandowski.com. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewCell: ReusableView {}

extension UICollectionView {
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Cannot dequeue reusable cell with reuse identifier")
        }
        return cell
    }
}
