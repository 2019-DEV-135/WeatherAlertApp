//
//  MainController.swift
//  WeatherAlertApp
//
//  Created by Umar Yaqub on 05/02/2019.
//  Copyright © 2019 Umar Yaqub. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Enter city here"
        sb.barTintColor = .gray
        sb.translatesAutoresizingMaskIntoConstraints = false
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        sb.delegate = self
        sb.showsCancelButton = true
        return sb
    }()
    
    var mainCollectionView: MainCollectionView!
    var networkManager: NetworkManager!
    let coreDataStack = CoreDataStack.shared
    var isFavLocationFetch = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // initialise network manager
        networkManager = NetworkManager(session: URLSession.shared)
        
        // setting view
        setupCollectionView()
        setupSearchBar()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = true
        mainCollectionView = MainCollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(mainCollectionView)
        mainCollectionView.mainCollectionViewDelegate = self
        
        mainCollectionView.translatesAutoresizingMaskIntoConstraints = false
        mainCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mainCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mainCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        mainCollectionView.currentWeatherViewModel = CurrentWeatherViewModel(traitCollection, currentWeather: nil)
        
        fetchSavedLocations()
    }

    private func setupSearchBar() {
        navigationController?.navigationBar.addSubview(searchBar)
        
        guard let navBar = navigationController?.navigationBar else { return }
        searchBar.topAnchor.constraint(equalTo: navBar.topAnchor).isActive = true
        searchBar.leftAnchor.constraint(equalTo: navBar.leftAnchor, constant: 8).isActive = true
        searchBar.rightAnchor.constraint(equalTo: navBar.rightAnchor, constant: -8).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchBar.isHidden = true
    }

}

