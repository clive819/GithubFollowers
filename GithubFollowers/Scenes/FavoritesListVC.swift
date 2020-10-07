//
//  FavoritesListVC.swift
//  GithubFollowers
//
//  Created by Clive Liu on 10/4/20.
//

import UIKit


class FavoritesListVC: UIViewController {
    
    private let tableView = UITableView()
    
    private var favorites: [Follower] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }

}


extension FavoritesListVC {
    
    private func layoutUI() {
        view.backgroundColor = .systemBackground
        configureTableView()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseableID)
    }
    
    private func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] (result) in
            guard let self = self else { return }

            switch result {
            case .success(let favorites):
                if favorites.isEmpty {
                    self.showEmptyStateView(message: "No favorites?\nAdd them on the follower screen.", in: self.view)
                    return
                }
                self.favorites = favorites
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.view.bringSubviewToFront(self.tableView)
                }
                
            case .failure(let error):
                self.presentGFAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
}


extension FavoritesListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseableID) as! FavoriteCell
        cell.set(favorite: favorites[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destinationVC = FollowerListVC(username: favorite.login)
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let favorite = favorites[indexPath.row]
        
        PersistenceManager.update(with: favorite, actionType: .remove) { [weak self] (error) in
            guard let self = self else { return }
            
            if let error = error {
                self.presentGFAlert(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
            }

            self.favorites.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .left)
        }
    }

}
