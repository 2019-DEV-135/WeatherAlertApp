//
//  CurrentWeatherViewModel.swift
//  WeatherAlertApp
//
//  Created by Umar Yaqub on 05/02/2019.
//  Copyright © 2019 Umar Yaqub. All rights reserved.
//

import UIKit

class CurrentWeatherViewModel {
    
    let traitCollection: UITraitCollection
    var currentWeather: CurrentWeather?
    
    init(_ traitCollection: UITraitCollection, currentWeather: CurrentWeather?) {
        self.traitCollection = traitCollection
        self.currentWeather = currentWeather
    }
    
    func getLocationAndCountryAttributedString() -> NSAttributedString {
        let location = currentWeather?.location ?? ""
        let country = currentWeather?.sys.country ?? ""
        if traitCollection.isIpad {
            let attributedText = NSMutableAttributedString(string: location, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
            attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 8)]))
            attributedText.append(NSAttributedString(string: country, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]))
            return attributedText
        } else {
            let attributedText = NSMutableAttributedString(string: location, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
            attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 6)]))
            attributedText.append(NSAttributedString(string: country, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
            return attributedText
        }
    }
    
    func getTempratureAttributedString() -> NSAttributedString {
        guard let temp = currentWeather?.main.temprature else { return NSAttributedString() }
        if traitCollection.isIpad {
            return NSAttributedString(string: "\(Int(temp)) ℃", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)])
        } else {
            return NSAttributedString(string: "\(Int(temp)) ℃", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
        }
    }
    
    func getFavouritesLabelAttributedString() -> NSAttributedString {
        if traitCollection.isIpad {
            return NSAttributedString(string: "Favourites", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)])
        } else {
            return NSAttributedString(string: "Favourites", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        }
    }
    
    func getCoverLabelAttributedString() -> NSAttributedString {
        if traitCollection.isIpad {
            return NSAttributedString(string: "Searched cities will appear here", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24)])
        } else {
            return NSAttributedString(string: "Searched cities will appear here", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        }
    }
    
    func isFavouriteButtonHidden() -> Bool {
        if currentWeather == nil {
            return true
        } else {
            return false
        }
    }
    
    func isCoverLabelHidden() -> Bool {
        if currentWeather == nil {
            return false
        } else {
            return true
        }
    }
    
    func getWeatherDescriptionImage(completion: @escaping (UIImage?) -> Void) {
        currentWeather?.weatherDetails.forEach({ (weatherDetail) in
            if weatherDetail.main == "Rain" {
                completion(UIImage(named: "Rainy"))
            } else if weatherDetail.main == "Clear" {
                completion(UIImage(named: "Sunny"))
            } else if weatherDetail.main == "Mist" {
                completion(UIImage(named: "Foggy"))
            } else {
                completion(UIImage(named: "Cloudy"))
            }
        })
    }
    
    func getFavouriteButtonTintColour(_ currentColour: UIColor) -> UIColor {
        return .red
    }
    
    func getFavouriteButtonDefaultTintColour() -> UIColor {
        return UIColor(white: 0.9, alpha: 0.6)
    }
}
