//
//  GFAvatarImageView.swift
//  GithubFollowers
//
//  Created by Clive Liu on 10/4/20.
//

import UIKit


class GFAvatarImageView: UIImageView {
    
    private let placeholderImage = Assets.avatarPlaceholder
    private let imageManager = ImageManager.shared
    private var imageUrl: String!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func downloadImage(from imageUrl: String) {
        self.imageUrl = imageUrl
        imageManager.addObserver(for: imageUrl, self)
        imageManager.retrieveImage(imageUrl: imageUrl)
    }
    
    func prepareForReuse() {
        imageManager.removeObserver(for: imageUrl, self)
        image = placeholderImage
    }
    
}


extension GFAvatarImageView {
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}


extension GFAvatarImageView: ImageObserver {
    
    func imageLoaded(image: UIImage) {
        DispatchQueue.main.async {
            self.image = image
        }
    }
    
}
