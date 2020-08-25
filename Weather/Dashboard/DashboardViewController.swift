//
//  DashboardViewController.swift
//  Weather
//
//  Created by m.lewandowski on 23/08/2020.
//  Copyright © 2020 michalewandowski.com. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class DashboardViewController: UIViewController {
	
	// MARK: - Attributes
	var presenter: DashboardPresenterProtocol!
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Views
    
    private let currentLocationView = UIView()
    private let collectionView = UICollectionView()
}

// MARK: - View Lifecycle
extension DashboardViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureComponents()
        presenter.inputs.viewDidLoadTrigger.accept(())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.inputs.viewWillAppearTrigger.accept(())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.inputs.viewWillDisappearTrigger.accept(())
    }
}

// MARK: - Private functions
private extension DashboardViewController {
    
    func configureComponents() {
        addSubviews()
        addConstraints()
        setupRx()
    }
    
    func addSubviews() {
    }
    
    func addConstraints() {
    }
    
    func setupRx() {
    }
}
