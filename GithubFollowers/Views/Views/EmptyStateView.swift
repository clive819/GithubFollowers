//
//  EmptyStateView.swift
//  GithubFollowers
//
//  Created by Clive Liu on 10/5/20.
//

import UIKit


class EmptyStateView: UIView {
    
    private let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    private let logoImageView = UIImageView()
    
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUI() {
        addSubviews(messageLabel, logoImageView)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        logoImageView.image = Assets.emptyStateLogo
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let labelCenterYConstraintConstant: CGFloat = (DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed) ? -80 : -150
        let logoBottomConstraintConstant: CGFloat = (DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed) ? 80 : 40
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170),
            logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: logoBottomConstraintConstant),
            
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: labelCenterYConstraintConstant),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
}

