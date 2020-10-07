//
//  GFItemInfoView.swift
//  GithubFollowers
//
//  Created by Clive Liu on 10/5/20.
//

import UIKit


enum ItemInfoType {
    case repo, gist, followers, following
}


class GFItemInfoView: UIView {
    
    private let symbolImageView = UIImageView()
    private let titleLable = GFTitleLabel(textAlignment: .left, fontSize: 14)
    private let countLabel = GFTitleLabel(textAlignment: .right, fontSize: 14)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(itemInfoType: ItemInfoType, count: Int) {
        countLabel.text = "\(count)"
        
        switch itemInfoType {
        case .repo:
            symbolImageView.image = SFSymbols.repo
            titleLable.text = "Public Repos"
        case .gist:
            symbolImageView.image = SFSymbols.gist
            titleLable.text = "Public Gists"
        case .followers:
            symbolImageView.image = SFSymbols.followers
            titleLable.text = "Followers"
        case .following:
            symbolImageView.image = SFSymbols.followering
            titleLable.text = "Following"
        }
    }

}


extension GFItemInfoView {
    
    private func layoutUI() {
        addSubviews(symbolImageView, titleLable, countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleToFill
        symbolImageView.tintColor = .label
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLable.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLable.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLable.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLable.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
    
}
