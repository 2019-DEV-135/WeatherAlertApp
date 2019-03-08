//
//  MainController+Handlers.swift
//  WeatherAlertApp
//
//  Created by Umar Yaqub on 05/02/2019.
//  Copyright © 2019 Umar Yaqub. All rights reserved.
//

import UIKit
import CoreData

extension MainController {
    
    func searchWeatherFor(_ city: String) {
        networkManager.getCurrentWeather(for: city) { (currentWeather, err, respErrorString) in
            //            print(currentWeather?.location)
            //            print(currentWeather?.coordinates.lat, currentWeather?.coordinates.lon)
            //            print(currentWeather?.main.temprature, currentWeather?.main.humidity, currentWeather?.main.pressure, currentWeather?.main.maximumTemprature, currentWeather?.main.minimumTemprature)
            //            print(currentWeather?.sys.country, currentWeather?.sys.sunrise, currentWeather?.sys.sunset)
            //            currentWeather?.weatherDetails.forEach({ (weather) in
            //                print(weather.description, weather.main)
            //            })
            guard let currentWeather = currentWeather else { return }
            // initialise view model with weather
            // determines if the fav locations need to be fetched or just the header (search location)
            if self.isFavLocationFetch {
                let currentWeatherViewModel = CurrentWeatherViewModel(self.traitCollection, currentWeather: currentWeather)
                self.mainCollectionView.currentWeatherViewModels?.append(currentWeatherViewModel)
            } else {
                self.mainCollectionView.currentWeatherViewModel = CurrentWeatherViewModel(self.traitCollection, currentWeather: currentWeather)
            }
            DispatchQueue.main.async {
                self.mainCollectionView.reloadData()
            }
        }
    }
    
    func fetchSavedLocations() {
        let viewContext = coreDataStack.viewContext
        let fetchLocationRequest: NSFetchRequest<WeatherLocation> = WeatherLocation.fetchRequest()
        do {
            let weatherLocation = try viewContext.fetch(fetchLocationRequest)
            weatherLocation.forEach { (city) in
                guard let city = city.city else { return }
                isFavLocationFetch = true
                searchWeatherFor(city)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveFavLocationToCoreData(_ location: String) {
        let viewContext = coreDataStack.viewContext
        let newLocation = WeatherLocation(context: viewContext)
        newLocation.city = location
        let result = coreDataStack.saveContext()
        print(result)
    }
    
    func removeFavLocationFromCoreData(_ location: String) {
        let viewContext = coreDataStack.viewContext
        let fetchLocationRequest: NSFetchRequest<WeatherLocation> = WeatherLocation.fetchRequest()
        do {
            let weatherLocation = try viewContext.fetch(fetchLocationRequest)
            weatherLocation.forEach { (city) in
                //guard let city = city.city else { return }
                if city.city == location {
                    viewContext.delete(city)
                    do {
                        try viewContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
