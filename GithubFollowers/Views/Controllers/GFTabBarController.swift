//
//  GFTabBarController.swift
//  GithubFollowers
//
//  Created by Clive Liu on 10/5/20.
//

import UIKit


class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNC(), createFavoritesNC()]
    }
    
    private func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        let navController = UINavigationController(rootViewController: searchVC)
        navController.navigationBar.prefersLargeTitles = true
        
        return navController
    }
    
    private func createFavoritesNC() -> UINavigationController {
        let favoritesListVC = FavoritesListVC()
        favoritesListVC.title = "Favorites"
        favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        let navController = UINavigationController(rootViewController: favoritesListVC)
        navController.navigationBar.prefersLargeTitles = true
        
        return navController
    }

}
