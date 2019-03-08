//
//  NetworkManager.swift
//  WeatherAlertApp
//
//  Created by Umar Yaqub on 05/02/2019.
//  Copyright © 2019 Umar Yaqub. All rights reserved.
//

import UIKit

class NetworkManager {
    
    private let session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }

    func getCurrentWeather(for city: String, completion: @escaping CurrentWeatherCallback) {
        session.getCurrentWeather(for: city) { (currentWeather, error, respError) in
            completion(currentWeather, error, respError)
        }
    }
}
