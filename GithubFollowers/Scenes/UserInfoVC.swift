//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Clive Liu on 10/5/20.
//

import UIKit


protocol UserInfoDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}


class UserInfoVC: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let headerView = UIView()
    private let itemViewOne = UIView()
    private let itemViewTwo = UIView()
    private let dateLabel = GFBodyLabel(textAlignment: .center)
    
    var username: String
    weak var delegate: UserInfoDelegate?

    
    init(username: String, delegate: UserInfoDelegate? = nil) {
        self.username = username
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        layoutUI()
        getUserInfo()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension UserInfoVC {
    
    private func configureDoneButton() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubviews(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    private func layoutUI() {
        configureDoneButton()
        configureScrollView()
        
        let views = [headerView, itemViewOne, itemViewTwo, dateLabel]
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        for subview in views {
            contentView.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                subview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                subview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: padding),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    private func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
                    self.add(childVC: GFRepoItemVC(user: user, delegate: self), to: self.itemViewOne)
                    self.add(childVC: GFFollowerItemVC(user: user, delegate: self), to: self.itemViewTwo)
                    self.dateLabel.text = "Github since \(user.createdAt.convertToMonthDayYear())"
                }
            case .failure(let error):
                self.presentGFAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
}


extension UserInfoVC: GFRepoItemDelegate {
    
    func didTapGithubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlert(title: "Invalid URL", message: "The url attached to this user is invalid.", buttonTitle: "Ok")
            return
        }
        presentSafariVC(with: url)
    }
    
}


extension UserInfoVC: GFFollowerItemDelegate {

    func didTapGetFollowers(for user: User) {
        delegate?.didRequestFollowers(for: user.login)
        dismissVC()
    }

}
