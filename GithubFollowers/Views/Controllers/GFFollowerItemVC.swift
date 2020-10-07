//
//  GFFollowerItemVC.swift
//  GithubFollowers
//
//  Created by Clive Liu on 10/5/20.
//

import UIKit


protocol GFFollowerItemDelegate: AnyObject {
    func didTapGetFollowers(for user: User)
}


class GFFollowerItemVC: GFItemInfoVC {
    
    weak var delegate: GFFollowerItemDelegate?
    
    
    init(user: User, delegate: GFFollowerItemDelegate?) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func actionButtonTapped() {
        delegate?.didTapGetFollowers(for: user)
    }
    
    private func configure() {
        itemInfoViewOne.set(itemInfoType: .followers, count: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, count: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }

}
