//
//  AddLocationViewController.swift
//  Weather
//
//  Created by m.lewandowski on 23/08/2020.
//  Copyright © 2020 michalewandowski.com. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class AddLocationViewController: UIViewController {
	
	// MARK: - Attributes
	var presenter: AddLocationPresenterProtocol!
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Views
    
    private let dismissLine: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.opacity = 0.4
        view.layer.cornerRadius = 2
        
        return view
    }()
    
    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Type city".uppercased()
        label.font = .systemFont(ofSize: 21, weight: .heavy)
        
        return label
    }()
    
    private let locationTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 10
        textField.font = .systemFont(ofSize: 16, weight: .medium)
        textField.textColor = .black
        textField.textAlignment = .center
        return textField
    }()
}

// MARK: - View Lifecycle
extension AddLocationViewController {
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
private extension AddLocationViewController {
    
    func configureComponents() {
        setupViews()
        setupConstraints()
        setupRx()
    }
    
    func setupViews() {
        view.addSubview(dismissLine)
        view.addSubview(container)
        container.addSubview(titleLabel)
        container.addSubview(locationTextField)
    }
    
    func setupConstraints() {
        dismissLine.snp.makeConstraints {
            $0.bottom.equalTo(container.snp.top).offset(-8)
            $0.width.equalTo(100)
            $0.height.equalTo(4)
            $0.centerX.equalToSuperview()
        }
        
        container.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        locationTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(40)
        }
    }
    
    func setupRx() {
        keyboardHeight()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] keyboardHeight in
                self?.container.snp.updateConstraints {
                    $0.height.equalTo(keyboardHeight + 200)
                }
            })
            .disposed(by: disposeBag)
        
        locationTextField.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { [weak self] _ in
            if let locationText = self?.locationTextField.text, !locationText.isEmpty {
                self?.presenter.saveLocation(city: locationText)
            }
            self?.dismiss(animated: true)
        })
    }
    
    func keyboardHeight() -> Observable<CGFloat> {
        return Observable
            .from([
                NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
                    .map { notification in
                        (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
                    },
                NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
                    .map { _ in 0 }
            ]).merge()
    }
}
