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
import XCoordinator

final class DashboardViewController: UIViewController, UIScrollViewDelegate {
	
	// MARK: - Attributes
	var presenter: DashboardPresenterProtocol!
    var router: UnownedRouter<AppRoute>?
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Views
    
    private let currentLocationView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private let currentLocationStackView: UIStackView = {
        let stackView = UIStackView()
        
        return stackView
    }()
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.register(LocationViewCell.self)
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
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
        setupViews()
        setupConstraints()
        setupRx()
    }
    
    func setupViews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        view.backgroundColor = .white
        
        view.addSubview(currentLocationView)
        view.addSubview(collectionView)
        currentLocationView.addSubview(currentLocationStackView)
    }
    
    func setupConstraints() {
        currentLocationView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.CurrentLocationView.top)
            $0.leading.equalToSuperview().offset(Constants.Margin.leading)
            $0.trailing.equalToSuperview().offset(Constants.Margin.trailing)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(currentLocationView.snp.bottom).offset(Constants.CollectionView.top)
            $0.leading.equalToSuperview().offset(Constants.Margin.leading)
            $0.trailing.equalToSuperview().offset(Constants.Margin.trailing)
            $0.bottom.equalToSuperview()
        }
    }
    
    func setupRx() {
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        presenter.outputs.currentLocWeather.subscribe(onNext: { viewModel in
            guard let viewModel = viewModel else { return }
            let icon = UIImageView(image: viewModel.icon)
            icon.snp.makeConstraints { $0.size.equalTo(100) }

            let temperatureLabel = UILabel()
            let temperatureString = String(format: "%.1f", viewModel.temperature)
            temperatureLabel.font = .systemFont(ofSize: 24, weight: .heavy)
            temperatureLabel.text = temperatureString

            let cityLabel = UILabel()
            cityLabel.font = .systemFont(ofSize: 17, weight: .heavy)
            cityLabel.text = viewModel.city
        }).disposed(by: disposeBag)
        
        presenter.outputs.savedLocWeather.drive(collectionView.rx.items) { (collectionView, row, viewModel) in
            let indexPath = IndexPath(row: row, section: 0)
            let cell: LocationViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setupView(viewModel: viewModel)
            return cell
        }.disposed(by: disposeBag)
    }
    
    @objc func addTapped() {
        router?.trigger(.addLocation)
    }
}

private extension DashboardViewController {
    struct Constants {
        struct Margin {
            static let leading: CGFloat = 20
            static let trailing: CGFloat = -20
        }
        
        struct CurrentLocationView {
            static let top: CGFloat = 10
        }
        
        struct CollectionView {
            static let top: CGFloat = 10
        }
    }
}
