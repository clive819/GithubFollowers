//
//  SearchVC.swift
//  GithubFollowers
//
//  Created by Clive Liu on 10/4/20.
//

import UIKit


class SearchVC: UIViewController {
    
    private let logoImageView = UIImageView()
    private let usernameTextField = GFTextField(placeholder: "Username")
    private let getFollowersButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        createDismissKeyboardGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

}


extension SearchVC {
    
    private func layoutUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubviews(logoImageView, usernameTextField, getFollowersButton)
        
        let topConstraintConstant: CGFloat = (DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed) ? 20 : 80
        logoImageView.image = Assets.logo
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        usernameTextField.delegate = self
        
        getFollowersButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        let padding: CGFloat = 50
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),

            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: padding),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usernameTextField.heightAnchor.constraint(equalToConstant: padding),
            
            getFollowersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            getFollowersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            getFollowersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            getFollowersButton.heightAnchor.constraint(equalToConstant: padding)
        ])
    }
    
    private func createDismissKeyboardGesture() {
        let gesture = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(gesture)
    }
    
    @objc private func pushFollowerListVC() {
        guard let username = usernameTextField.text, !username.isEmpty else {
            presentGFAlert(title: "Empty Username", message: "Please enter a username. We need to know who to look for 🙂.", buttonTitle: "Ok")
            return
        }
        
        let followerListVC = FollowerListVC(username: username)
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
}


extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        pushFollowerListVC()
        return true
    }
    
}
