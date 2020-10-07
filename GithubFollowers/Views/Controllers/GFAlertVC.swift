//
//  GFAlertVC.swift
//  GithubFollowers
//
//  Created by Clive Liu on 10/4/20.
//

import UIKit


class GFAlertVC: UIViewController {
    
    private let containerView = GFAlertContainerView()
    private let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    private let messageLabel = GFBodyLabel(textAlignment: .center)
    private let actionButton = GFButton(backgroundColor: .systemPink, title: "Ok")
    private let padding: CGFloat = 20
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    
    init(title: String?, message: String?, buttonTitle: String?) {
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension GFAlertVC {
    
    private func layoutUI() {
        view.addSubviews(containerView, titleLabel, actionButton, messageLabel)
        
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(self.dismissVC), for: .touchUpInside)
        
        messageLabel.text = message ?? ""
        messageLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
            
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44),
            
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
}
