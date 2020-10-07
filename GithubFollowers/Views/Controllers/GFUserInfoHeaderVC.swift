//
//  GFUserInfoHeaderVC.swift
//  GithubFollowers
//
//  Created by Clive Liu on 10/5/20.
//

import UIKit


class GFUserInfoHeaderVC: UIViewController {
    
    private let avatarImageView = GFAvatarImageView(frame: .zero)
    private let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 34)
    private let nameLabel = GFSecondaryTitleLabel(fontSize: 18)
    private let locationImageView = UIImageView()
    private let locationLabel = GFSecondaryTitleLabel(fontSize: 18)
    private let bioLabel = GFBodyLabel(textAlignment: .left)
    private let textImagePadding: CGFloat = 12
    
    private var user: User
    
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
    }
    
}


extension GFUserInfoHeaderVC {
    
    private func layoutUI() {
        view.addSubviews(avatarImageView, usernameLabel, nameLabel, locationImageView, locationLabel, bioLabel)
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.downloadImage(from: user.avatarUrl)
        
        usernameLabel.text = user.login
        
        nameLabel.text = user.name ?? "John Doe"
        
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        locationImageView.image = SFSymbols.pin
        locationImageView.tintColor = .secondaryLabel
        
        locationLabel.text = user.location ?? "No Location"
        
        bioLabel.text = user.bio ?? "No Bio"
        bioLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
}
