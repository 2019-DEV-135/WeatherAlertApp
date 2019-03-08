//
//  MainController+Delegate.swift
//  WeatherAlertApp
//
//  Created by Umar Yaqub on 05/02/2019.
//  Copyright © 2019 Umar Yaqub. All rights reserved.
//

import UIKit

extension MainController: UISearchBarDelegate, MainCollectionViewDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let city = searchBar.text else { return }
        isFavLocationFetch = false
        searchWeatherFor(city)
    }
    
    func didAddNewFavLocation(_ location: String) {
        saveFavLocationToCoreData(location)
    }
    
    func didRemoveFavLocation(_ location: String) {
        removeFavLocationFromCoreData(location)
    }
    
    func didNavigateToDetailView(_ currentWeather: CurrentWeather) {
        let detailController = DetailController()
        detailController.currentWeather = currentWeather
        navigationController?.pushViewController(detailController, animated: true)
    }
}
