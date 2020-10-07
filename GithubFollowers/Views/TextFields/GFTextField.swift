//
//  GFTextField.swift
//  GithubFollowers
//
//  Created by Clive Liu on 10/4/20.
//

import UIKit


class GFTextField: UITextField {
    
    convenience init(placeholder: String) {
        self.init(frame: .zero)
        self.placeholder = placeholder
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label
        
        returnKeyType = .go
        minimumFontSize = 12
        textAlignment = .center
        autocorrectionType = .no
        clearButtonMode = .always
        autocapitalizationType = .none
        adjustsFontSizeToFitWidth = true
        backgroundColor = .tertiarySystemBackground
        font = UIFont.preferredFont(forTextStyle: .title2)

        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
