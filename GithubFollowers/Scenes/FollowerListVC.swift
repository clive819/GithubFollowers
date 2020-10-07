//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Clive Liu on 10/4/20.
//

import UIKit


class FollowerListVC: GFDataLoadingVC {
    
    enum Section { case main }
    
    private var page = 1
    private var isLoadingMoreFollowers = false
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    private lazy var filteredFollowers: [Follower] = []
    
    var username: String
    var followers: [Follower] = []
    
    
    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
        title = username
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        getFollowers(page: page)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}


extension FollowerListVC {
    
    private func layoutUI() {
        view.backgroundColor = .systemBackground
        
        configureSearchController()
        configureCollectionView()
        configureDataSource()
        configureFavoriteButton()
    }
    
    private func configureFavoriteButton() {
        let addButton = UIBarButtonItem(image: SFSymbols.favorite, style: .plain, target: self, action: #selector(addToFavorite))
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - padding * 2 - minimumItemSpacing * 2
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.resuableID)
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.resuableID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    private func updateData(on data: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data)
        
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil) }
    }
    
    private func getFollowers(page: Int) {
        showLoadingView()
        isLoadingMoreFollowers = true
        
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] ( result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let followers):
                self.updateUI(with: followers)
            case .failure(let error):
                self.presentGFAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
            
            self.isLoadingMoreFollowers = false
            self.dismissLoadingView()
        }
    }
    
    private func updateUI(with followers: [Follower]) {
        self.followers.append(contentsOf: followers)
        if followers.isEmpty {
            DispatchQueue.main.async { self.showEmptyStateView(message: "This user has no followers. Go follow them 😉.", in: self.view) }
        }else {
            updateData(on: self.followers)
        }
    }
    
    @objc private func addToFavorite() {
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                PersistenceManager.update(with: favorite, actionType: .add) { (error) in
                    if let error = error {
                        self.presentGFAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                        return
                    }
                    self.presentGFAlert(title: "Success!", message: "You have successfully favorite this user🎉", buttonTitle: "Ok")
                }
                
            case .failure(let error):
                self.presentGFAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
}


extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = collectionView.frame.size.height
        
        if offsetY + height >= contentHeight {
            guard !isLoadingMoreFollowers, followers.count % 100 == 0 else { return }
            page += 1
            getFollowers(page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FollowerCell
        guard let username = cell.usernameLabel.text else { return }
        
        let destinationVC = UserInfoVC(username: username, delegate: self)
        let navController = UINavigationController(rootViewController: destinationVC)
        present(navController, animated: true, completion: nil)
    }
    
}


extension FollowerListVC: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard !followers.isEmpty, let filter = searchController.searchBar.text?.lowercased(), !filter.isEmpty else {
            updateData(on: followers)
            return
        }
        filteredFollowers = followers.filter({ $0.login.lowercased().contains(filter) })
        updateData(on: filteredFollowers)
    }

}


extension FollowerListVC: UserInfoDelegate {
    
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(page: page)
    }
    
}
