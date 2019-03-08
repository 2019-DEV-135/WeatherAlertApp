//
//  MainHeaderTests.swift
//  WeatherAlertAppTests
//
//  Created by Umar Yaqub on 06/02/2019.
//  Copyright © 2019 Umar Yaqub. All rights reserved.
//

import Foundation
import XCTest
@testable import WeatherAlertApp

class MainHeaderTests: XCTestCase, MainHeaderDelegate {
    
    var sut: MainHeader!
    var wasFavouritesTapped: Bool!
    
    override func setUp() {
        super.setUp()
        
        sut = MainHeader(frame: .zero)
        sut.delegate = self
        wasFavouritesTapped = false
    }
    
    override func tearDown() {
        sut = nil
        wasFavouritesTapped = nil
        super.tearDown()
    }
    
    func didAddToFavourites(_ currentWeatherViewModel: CurrentWeatherViewModel) {
        wasFavouritesTapped = true
    }
    
    func testFavouritesButtonWasTapped() {
        sut.favouriteButton.sendActions(for: .touchUpInside)
        XCTAssert(wasFavouritesTapped)
    }
}
