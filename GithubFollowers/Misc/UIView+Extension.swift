//
//  UIView+Extension.swift
//  GithubFollowers
//
//  Created by Clive Liu on 10/5/20.
//

import UIKit


extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
}
