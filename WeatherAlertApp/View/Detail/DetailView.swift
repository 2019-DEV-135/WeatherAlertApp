//
//  DetailView.swift
//  WeatherAlertApp
//
//  Created by Umar Yaqub on 07/02/2019.
//  Copyright © 2019 Umar Yaqub. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    let locationCountryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let tempratureLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let weatherDescriptionImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let windDirectionAndSpeedLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let windDirectionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var detailViewModel: DetailViewModel!
    
    required init(traitCollection: UITraitCollection, currentWeather: CurrentWeather) {
        super.init(frame: .zero)
        backgroundColor = .white

        detailViewModel = DetailViewModel(traitCollection, currentWeather: currentWeather)
        
        addSubview(locationCountryLabel)
        addSubview(weatherDescriptionImageView)
        addSubview(tempratureLabel)
        addSubview(windDirectionAndSpeedLabel)
        addSubview(windDirectionLabel)
        
        setupLocationAndCountryLabel()
        setupWeatherDescriptionImageView()
        setupTempratureLabel()
        setupWindDirectionAndSpeedLabel()
        setupWindDirectionLabel()
    }
    
    private func setupLocationAndCountryLabel() {
        locationCountryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        locationCountryLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        locationCountryLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        locationCountryLabel.heightAnchor.constraint(equalToConstant: 120).isActive = true
        //set text
        locationCountryLabel.attributedText = detailViewModel.getLocationAndCountryAttributedString()
    }
    
    private func setupWeatherDescriptionImageView() {
        weatherDescriptionImageView.leftAnchor.constraint(equalTo: locationCountryLabel.leftAnchor).isActive = true
        weatherDescriptionImageView.topAnchor.constraint(equalTo: locationCountryLabel.bottomAnchor, constant: 0).isActive = true
        weatherDescriptionImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        weatherDescriptionImageView.heightAnchor.constraint(equalTo: weatherDescriptionImageView.widthAnchor, multiplier: 1).isActive = true
        //set image
        detailViewModel.getWeatherDescriptionImage { (image) in
            DispatchQueue.main.async {
                self.weatherDescriptionImageView.image = image
            }
        }
    }
    
    private func setupTempratureLabel() {
        tempratureLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        tempratureLabel.topAnchor.constraint(equalTo: weatherDescriptionImageView.topAnchor, constant: 0).isActive = true
        tempratureLabel.bottomAnchor.constraint(equalTo: weatherDescriptionImageView.bottomAnchor, constant: 0).isActive = true
        tempratureLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        //set text
        tempratureLabel.attributedText = detailViewModel.getTempratureAttributedString()
    }
    
    private func setupWindDirectionAndSpeedLabel() {
        windDirectionAndSpeedLabel.topAnchor.constraint(equalTo: weatherDescriptionImageView.bottomAnchor, constant: 5).isActive = true
        windDirectionAndSpeedLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        windDirectionAndSpeedLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        windDirectionAndSpeedLabel.rightAnchor.constraint(equalTo: windDirectionLabel.leftAnchor).isActive = true
        // set text
        windDirectionAndSpeedLabel.attributedText = detailViewModel.getWindDirectionAndSpeedAttributedString()
    }
    
    private func setupWindDirectionLabel() {
        windDirectionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        windDirectionLabel.heightAnchor.constraint(equalToConstant: 84).isActive = true
        windDirectionLabel.widthAnchor.constraint(equalToConstant: 84).isActive = true
        windDirectionLabel.centerYAnchor.constraint(equalTo: windDirectionAndSpeedLabel.centerYAnchor).isActive = true
        
        windDirectionLabel.attributedText = detailViewModel.getWindDirectionAttributedString()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
