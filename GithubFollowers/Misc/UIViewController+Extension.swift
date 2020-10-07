//
//  UIViewController+Extension.swift
//  GithubFollowers
//
//  Created by Clive Liu on 10/4/20.
//

import UIKit
import SafariServices


extension UIViewController {
    
    func presentGFAlert(title: String?, message: String?, buttonTitle: String?) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true, completion: nil)
    }
    
    func showEmptyStateView(message: String, in view: UIView) {
        let emptyStateView = EmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        emptyStateView.backgroundColor = .systemBackground
        view.addSubview(emptyStateView)
    }

}
