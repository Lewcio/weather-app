//
//  DetailsViewController.swift
//  Weather
//
//  Created by m.lewandowski on 23/08/2020.
//  Copyright © 2020 michalewandowski.com. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class DetailsViewController: UIViewController {
	
	// MARK: - Attributes
	var presenter: DetailsPresenterProtocol!
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Views
}

// MARK: - View Lifecycle
extension DetailsViewController {
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
private extension DetailsViewController {
    
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
