//
//  DetailViewModelTests.swift
//  WeatherAlertAppTests
//
//  Created by Umar Yaqub on 07/02/2019.
//  Copyright © 2019 Umar Yaqub. All rights reserved.
//

import Foundation
import XCTest
@testable import WeatherAlertApp

class DetailViewModelTests: XCTestCase {
    
    var sut: DetailViewModel!
    var traitCollection: UITraitCollection!
    let json = ["coord":
        ["lon":145.77,"lat":-16.92],
                "weather":[["id":803,"main":"Clouds","description":"broken clouds","icon":"04n"]],
                "base":"cmc stations",
                "main":["temp":293.25,"pressure":1019,"humidity":83,"temp_min":289.82,"temp_max":295.37],
                "wind":["speed":5.1,"deg":150],
                "clouds":["all":75],
                "rain":["3h":3],
                "dt":1435658272,
                "sys":["type":1,"id":8166,"message":0.0166,"country":"AU","sunrise":1435610796,"sunset":1435650870],
                "id":2172797,
                "name":"Cairns",
                "cod":200] as [String : Any]
    
    override func setUp() {
        super.setUp()
        
        // setting traits
        let iPadTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .regular), UITraitCollection(verticalSizeClass: .regular)])
        let iPhonePortraitTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)])
        let iPhoneLandscapeTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .compact)])
        traitCollection = iPadTraits
        
        setupCurrentWeather()
    }
    
    override func tearDown() {
        sut = nil
        traitCollection = nil
        super.tearDown()
    }
    
    private func setupCurrentWeather() {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
            let currentWeather = try JSONDecoder().decode(CurrentWeather.self, from: jsonData)
            sut = DetailViewModel(traitCollection, currentWeather: currentWeather)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func testGetsLocationAndCountryAttributedString() {
        let location = sut.currentWeather?.location ?? ""
        let country = sut.currentWeather?.sys.country ?? ""
        if traitCollection.isIpad {
            let attributedText = NSMutableAttributedString(string: location, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 35)])
            attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]))
            attributedText.append(NSAttributedString(string: country, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26)]))
            XCTAssertEqual(sut.getLocationAndCountryAttributedString(), attributedText)
        } else {
            let attributedText = NSMutableAttributedString(string: location, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)])
            attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)]))
            attributedText.append(NSAttributedString(string: country, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]))
            XCTAssertEqual(sut.getLocationAndCountryAttributedString(), attributedText)
        }
    }
    
    func testGetsTempratureAttributedString() {
        guard let temp = sut.currentWeather?.main.temprature else { return }
        if traitCollection.isIpad {
            let attributedText = NSAttributedString(string: "\(Int(temp)) ℃", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 35)])
            XCTAssertEqual(sut.getTempratureAttributedString(), attributedText)
        } else {
            let attributedText = NSAttributedString(string: "\(Int(temp)) ℃", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)])
            XCTAssertEqual(sut.getTempratureAttributedString(), attributedText)
        }
    }
    
    func testGetsWindDirectionAndSpeedAttributedString() {
        guard let speed = sut.currentWeather?.wind.speed else { return }
        guard let degrees = sut.currentWeather?.wind.degrees else { return }
        if traitCollection.isIpad {
            let attributedText = NSMutableAttributedString(string: "\(speed)", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 35)])
            attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]))
            attributedText.append(NSAttributedString(string: convertDegreesToDirection(degrees), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26)]))
            XCTAssertEqual(sut.getWindDirectionAndSpeedAttributedString(), attributedText)
        } else {
            let attributedText = NSMutableAttributedString(string: "\(speed)", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)])
            attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)]))
            attributedText.append(NSAttributedString(string: convertDegreesToDirection(degrees), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]))
            XCTAssertEqual(sut.getWindDirectionAndSpeedAttributedString(), attributedText)
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
    
    func testGetsWindDirectionAttributedString() {
        guard let degrees = sut.currentWeather?.wind.degrees else { return }
        if traitCollection.isIpad {
            let direction = convertDirectionIntoShortForm(convertDegreesToDirection(degrees))
            let attributedString = NSAttributedString(string: direction, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 45)])
            XCTAssertEqual(sut.getWindDirectionAttributedString(), attributedString)
        } else {
            let direction = convertDirectionIntoShortForm(convertDegreesToDirection(degrees))
            let attributedString = NSAttributedString(string: direction, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 35)])
            XCTAssertEqual(sut.getWindDirectionAttributedString(), attributedString)
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
    
    
    func testGetsWeatherDescriptionRainyImage() {
        sut.getWeatherDescriptionImage { (image) in
            XCTAssertEqual(image, UIImage(named: "Rainy"))
        }
    }
    
    func testGetsWeatherDescriptionSunnyImage() {
        sut.getWeatherDescriptionImage { (image) in
            XCTAssertEqual(image, UIImage(named: "Sunny"))
        }
    }
    
    func testGetsWeatherDescriptionFoggyImage() {
        sut.getWeatherDescriptionImage { (image) in
            XCTAssertEqual(image, UIImage(named: "Foggy"))
        }
    }
    
    func testGetsWeatherDescriptionCloudyImage() {
        sut.getWeatherDescriptionImage { (image) in
            XCTAssertEqual(image, UIImage(named: "Cloudy"))
        }
    }
    
}

