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
import CoreLocation

final class DashboardViewController: UIViewController, UIScrollViewDelegate, CLLocationManagerDelegate {
	
	// MARK: - Attributes
	var presenter: DashboardPresenterProtocol!
    var router: UnownedRouter<AppRoute>?
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Views
    
    private let currentLocationImage = UIImageView(image: R.image.location())
    
    private let currentLocationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.CurrentLocationLabel.fontSize, weight: .light)
        label.textColor = .black
        label.text = "Current location"
        
        return label
    }()
    
    private let currentLocationView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private let currentLocationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        
        return stackView
    }()
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.register(LocationViewCell.self)
        collectionView.backgroundColor = .black
        
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
}

// MARK: - Private functions
private extension DashboardViewController {
    
    func configureComponents() {
        setupViews()
        setupConstraints()
        setupRx()
    }
    
    func setupViews() {
        navigationController?.navigationBar.barStyle = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        view.backgroundColor = .black
        
        view.addSubview(currentLocationView)
        view.addSubview(collectionView)
        currentLocationView.addSubview(currentLocationImage)
        currentLocationView.addSubview(currentLocationLabel)
        currentLocationView.addSubview(currentLocationStackView)
    }
    
    func setupConstraints() {
        currentLocationView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(Constants.CurrentLocationView.top)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(Constants.Margin.leading)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(Constants.Margin.trailing)
        }
        
        currentLocationImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.CurrentLocationStackView.top)
            $0.leading.equalToSuperview().offset(Constants.CurrentLocationImage.leading)
            $0.size.equalTo(Constants.CurrentLocationImage.size)
        }
        
        currentLocationLabel.snp.makeConstraints {
            $0.centerY.equalTo(currentLocationImage.snp.centerY)
            $0.leading.equalTo(currentLocationImage.snp.trailing).offset(Constants.CurrentLocationLabel.leading)
            $0.trailing.equalToSuperview().offset(Constants.CurrentLocationLabel.trailing)
        }
        
        currentLocationStackView.snp.makeConstraints {
            $0.top.equalTo(currentLocationImage.snp.bottom).offset(Constants.CurrentLocationStackView.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(Constants.CurrentLocationStackView.bottom)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(currentLocationView.snp.bottom).offset(Constants.CollectionView.top)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(Constants.Margin.leading)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(Constants.Margin.trailing)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func setupRx() {
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        presenter.outputs.currentLocWeather.subscribe(onNext: { viewModel in
            guard let viewModel = viewModel else { return }
            let image = UIImageView(image: viewModel.icon)
            image.snp.makeConstraints { $0.size.equalTo(Constants.WeatherIcon.size) }

            let temperatureLabel = UILabel()
            let temperatureString = String(format: "%.1f", viewModel.temperature)
            temperatureLabel.font = .systemFont(ofSize: Constants.TemperatureLabel.fontSize, weight: .heavy)
            temperatureLabel.textColor = .white
            temperatureLabel.text = "\(temperatureString) ℃"

            let cityLabel = UILabel()
            cityLabel.font = .systemFont(ofSize: Constants.CityLabel.fontSize, weight: .semibold)
            cityLabel.textColor = .white
            cityLabel.text = viewModel.city
            
            self.currentLocationStackView.addArrangedSubview(image)
            self.currentLocationStackView.addArrangedSubview(temperatureLabel)
            self.currentLocationStackView.addArrangedSubview(cityLabel)
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

extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width, height: Constants.CollectionView.height)
    }
}

private extension DashboardViewController {
    struct Constants {
        struct Margin {
            static let leading: CGFloat = 20
            static let trailing: CGFloat = -20
        }
        
        struct CurrentLocationImage {
            static let leading: CGFloat = 20
            static let size: CGFloat = 20
        }
        
        struct CurrentLocationView {
            static let top: CGFloat = 10
        }
        
        struct CurrentLocationLabel {
            static let leading: CGFloat = 10
            static let trailing: CGFloat = -20
            static let fontSize: CGFloat = 14
        }
        
        struct CurrentLocationStackView {
            static let top: CGFloat = 20
            static let bottom: CGFloat = -20
        }
        
        struct TemperatureLabel {
            static let fontSize: CGFloat = 36
        }
        
        struct WeatherIcon {
            static let size: CGFloat = 60
        }
        
        struct CityLabel {
            static let fontSize: CGFloat = 17
        }
        
        struct CollectionView {
            static let top: CGFloat = 10
            static let height: CGFloat = 100
        }
    }
}
