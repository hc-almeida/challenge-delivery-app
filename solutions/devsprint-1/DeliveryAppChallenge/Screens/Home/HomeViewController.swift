//
//  ViewController.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 25/10/21.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let deliveryApi: DeliveryApiProtocol
    private let customView: HomeViewProtocol
    
    // MARK: - Inits
    
    init(customView: HomeViewProtocol, deliveryApi: DeliveryApiProtocol) {
        self.customView = customView
        self.deliveryApi = deliveryApi
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Delivery App"
        setupSearchBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchRestaurants()
    }
    
    func fetchRestaurants() {
        
        deliveryApi.fetchRestaurants { [weak self] restaurants in
            //        self.restaurants = restaurants
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.customView.displayRestaurants(.init(restaurants: restaurants))
            }
        }
    }
    
    // MARK: - Private Functions
    
    private func setupSearchBar() {
        let searchController = UISearchController()
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Nome do restaurante"
        searchController.obscuresBackgroundDuringPresentation = false
    }
}

// MARK: - HomeViewDelegate Extension

extension HomeViewController: HomeViewDelegate {
    
}

// MARK: - UISearchBarDelegate Extension

extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
