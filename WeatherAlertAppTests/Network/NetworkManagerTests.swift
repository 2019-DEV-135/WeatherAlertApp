//
//  NetworkManagerTests.swift
//  WeatherAlertAppTests
//
//  Created by Umar Yaqub on 06/02/2019.
//  Copyright © 2019 Umar Yaqub. All rights reserved.
//

import Foundation
import XCTest
@testable import WeatherAlertApp

class NetowrkManagerTests: XCTestCase {
    
    var sut: NetworkManager!
    var session: NetworkSessionMock!
    let city = "City"
    
    override func setUp() {
        super.setUp()
        
        session = NetworkSessionMock()
        sut = NetworkManager(session: session)
    }
    
    override func tearDown() {
        sut = nil
        session = nil
        super.tearDown()
    }
    
    func testResumeWasCalled() {
        session.getCurrentWeather(for: city) { (currentWeather, err, httpUrlRespError) in
        }
        XCTAssert(session.wasResumeCalled)
    }
    
    func testCitySearchedWasCorrect() {
        session.getCurrentWeather(for: city) { (currentWeather, err, httpUrlRespError) in
        }
        XCTAssertEqual(session.citySearched, city)
    }
}

