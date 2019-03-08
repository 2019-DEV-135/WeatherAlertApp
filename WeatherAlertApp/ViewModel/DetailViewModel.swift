//
//  DetailViewModel.swift
//  WeatherAlertApp
//
//  Created by Umar Yaqub on 07/02/2019.
//  Copyright © 2019 Umar Yaqub. All rights reserved.
//

import UIKit

class DetailViewModel {
    
    let traitCollection: UITraitCollection
    let currentWeather: CurrentWeather?
    
    init(_ traitCollection: UITraitCollection, currentWeather: CurrentWeather) {
        self.traitCollection = traitCollection
        self.currentWeather = currentWeather
    }
    
    func getLocationAndCountryAttributedString() -> NSAttributedString {
        let location = currentWeather?.location ?? ""
        let country = currentWeather?.sys.country ?? ""
        if traitCollection.isIpad {
            let attributedText = NSMutableAttributedString(string: location, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 35)])
            attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]))
            attributedText.append(NSAttributedString(string: country, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26)]))
            return attributedText
        } else {
            let attributedText = NSMutableAttributedString(string: location, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)])
            attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)]))
            attributedText.append(NSAttributedString(string: country, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]))
            return attributedText
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
    
    func getTempratureAttributedString() -> NSAttributedString {
        guard let temp = currentWeather?.main.temprature else { return NSAttributedString() }
        if traitCollection.isIpad {
            return NSAttributedString(string: "\(Int(temp)) ℃", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 35)])
        } else {
            return NSAttributedString(string: "\(Int(temp)) ℃", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)])
        }
    }
    
    func getWindDirectionAndSpeedAttributedString() -> NSAttributedString {
        guard let speed = currentWeather?.wind.speed else { return NSAttributedString() }
        guard let degrees = currentWeather?.wind.degrees else { return NSAttributedString() }
        if traitCollection.isIpad {
            let attributedText = NSMutableAttributedString(string: "\(speed)", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 35)])
            attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]))
            attributedText.append(NSAttributedString(string: convertDegreesToDirection(degrees), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26)]))
            return attributedText
        } else {
            let attributedText = NSMutableAttributedString(string: "\(speed)", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)])
            attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)]))
            attributedText.append(NSAttributedString(string: convertDegreesToDirection(degrees), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]))
            return attributedText
        }
    }
    
    private func convertDegreesToDirection(_ degrees: Double) -> String {
        if(degrees > 23 && degrees <= 67){
            return "North East"
        } else if degrees > 68 && degrees <= 112 {
            return "East"
        } else if degrees > 113 && degrees <= 167 {
            return "South East"
        } else if degrees > 168 && degrees <= 202 {
            return "South"
        } else if degrees > 203 && degrees <= 247 {
            return "South West"
        } else if degrees > 248 && degrees <= 293 {
            return "West"
        } else if degrees > 294 && degrees <= 337 {
            return "North West"
        } else if degrees >= 338 || degrees <= 22 {
            return "North"
        } else {
            return ""
        }
    }
    
    func getWindDirectionAttributedString() -> NSAttributedString {
        guard let degrees = currentWeather?.wind.degrees else { return NSAttributedString() }
        if traitCollection.isIpad {
            let direction = convertDirectionIntoShortForm(convertDegreesToDirection(degrees))
            return NSAttributedString(string: direction, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 45)])
        } else {
            let direction = convertDirectionIntoShortForm(convertDegreesToDirection(degrees))
            return NSAttributedString(string: direction, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 35)])
        }
    }
    
    private func convertDirectionIntoShortForm(_ direction: String) -> String {
        if direction == "North East" {
            return "NE"
        } else if direction == "East" {
            return "E"
        } else if direction == "South East" {
            return "SE"
        } else if direction == "South" {
            return "S"
        } else if direction == "South West" {
            return "SW"
        } else if direction == "West" {
            return "W"
        } else if direction == "North West" {
            return "NW"
        } else if direction == "North" {
            return "N"
        } else {
            return ""
        }
    }
}
