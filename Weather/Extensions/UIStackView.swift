//
//  UIStackView.swift
//  Weather
//
//  Created by m.lewandowski on 02/09/2020.
//  Copyright © 2020 michalewandowski.com. All rights reserved.
//

import UIKit


extension UIStackView {
    func removeAllArrangedSubviews() {
        self.arrangedSubviews.forEach({ $0.removeFromSuperview() })
    }
}
