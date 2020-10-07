//
//  GFRepoItemVC.swift
//  GithubFollowers
//
//  Created by Clive Liu on 10/5/20.
//

import UIKit


protocol GFRepoItemDelegate: AnyObject {
    func didTapGithubProfile(for user: User)
}


class GFRepoItemVC: GFItemInfoVC {
    
    weak var delegate: GFRepoItemDelegate?
    
    
    init(user: User, delegate: GFRepoItemDelegate?) {
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
        delegate?.didTapGithubProfile(for: user)
    }
    
    private func configure() {
        itemInfoViewOne.set(itemInfoType: .repo, count: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gist, count: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }

}
