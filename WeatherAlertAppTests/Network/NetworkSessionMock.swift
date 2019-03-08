//
//  NetworkSessionMock.swift
//  WeatherAlertAppTests
//
//  Created by Umar Yaqub on 06/02/2019.
//  Copyright © 2019 Umar Yaqub. All rights reserved.
//

import Foundation
@testable import WeatherAlertApp

class NetworkSessionMock: NetworkSession {
    
    var wasResumeCalled = false
    var citySearched: String!
    
    func getCurrentWeather(for city: String, completion: @escaping CurrentWeatherCallback) {
        wasResumeCalled = true
        citySearched = city
        
    }
    
    
}
