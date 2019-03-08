//
//  CurrentWeatherViewModelTests.swift
//  WeatherAlertAppTests
//
//  Created by Umar Yaqub on 06/02/2019.
//  Copyright © 2019 Umar Yaqub. All rights reserved.
//

import Foundation
import XCTest
@testable import WeatherAlertApp

class CurrentWeatherViewModelTests: XCTestCase {
    
    var sut: CurrentWeatherViewModel!
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
            sut = CurrentWeatherViewModel(traitCollection, currentWeather: currentWeather)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func testGetsLocationAndCountryAttributedString() {
        let location = sut.currentWeather?.location ?? ""
        let country = sut.currentWeather?.sys.country ?? ""
        if traitCollection.isIpad {
            let attributedText = NSMutableAttributedString(string: location, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
            attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 8)]))
            attributedText.append(NSAttributedString(string: country, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]))
            XCTAssertEqual(sut.getLocationAndCountryAttributedString(), attributedText)
        } else {
            let attributedText = NSMutableAttributedString(string: location, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
            attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 6)]))
            attributedText.append(NSAttributedString(string: country, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
            XCTAssertEqual(sut.getLocationAndCountryAttributedString(), attributedText)
        }
    }
    
    func testGetsTempratureAttributedString() {
        guard let temp = sut.currentWeather?.main.temprature else { return }
        if traitCollection.isIpad {
            let attributedText = NSAttributedString(string: "\(Int(temp)) ℃", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)])
            XCTAssertEqual(sut.getTempratureAttributedString(), attributedText)
        } else {
            let attributedText = NSAttributedString(string: "\(Int(temp)) ℃", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
            XCTAssertEqual(sut.getTempratureAttributedString(), attributedText)
        }
    }
    
    func testGetsFavouritesLabelAttributedString() {
        if traitCollection.isIpad {
            let attributedText = NSAttributedString(string: "Favourites", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)])
            XCTAssertEqual(sut.getFavouritesLabelAttributedString(), attributedText)
        } else {
            let attributedText = NSAttributedString(string: "Favourites", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
            XCTAssertEqual(sut.getFavouritesLabelAttributedString(), attributedText)
        }
    }
    
    func testGetsCoverLabelAttributedString() {
        if traitCollection.isIpad {
            let attributedText = NSAttributedString(string: "Searched cities will appear here", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24)])
            XCTAssertEqual(sut.getCoverLabelAttributedString(), attributedText)
        } else {
            let attributedText = NSAttributedString(string: "Searched cities will appear here", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
            XCTAssertEqual(sut.getCoverLabelAttributedString(), attributedText)
        }
    }
    
    func testIsFavouriteButtonHidden() {
        if sut.currentWeather == nil {
            XCTAssertEqual(sut.isFavouriteButtonHidden(), true)
        } else {
            XCTAssertEqual(sut.isFavouriteButtonHidden(), false)
        }
    }
    
    func testIsCoverLabelHidden() {
        if sut.currentWeather == nil {
            XCTAssertEqual(sut.isCoverLabelHidden(), false)
        } else {
            XCTAssertEqual(sut.isCoverLabelHidden(), true)
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
    
    func testGetsFavouriteButtonTintColourRedFromLight() {
        let currentColour = UIColor(white: 0.9, alpha: 0.6)
        XCTAssertEqual(sut.getFavouriteButtonTintColour(currentColour), UIColor.red)
    }
}
