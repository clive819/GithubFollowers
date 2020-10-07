//
//  ImageManager.swift
//  GithubFollowers
//
//  Created by Clive Liu on 10/4/20.
//

import UIKit


protocol ImageObserver: AnyObject {
    func imageLoaded(image: UIImage)
}


class ImageManager {
    
    static let shared = ImageManager()
    
    private struct Observer { weak var observer: ImageObserver? }
    
    private var observers = [String: [ObjectIdentifier: Observer]]()
    
    
    private init(){}
    
    func addObserver(for url: String, _ observer: ImageObserver) {
        if observers[url] == nil {
            observers[url] = [ObjectIdentifier(observer): Observer(observer: observer)]
        }else {
            observers[url]![ObjectIdentifier(observer)] = Observer(observer: observer)
        }
    }
    
    func removeObserver(for url: String, _ observer: ImageObserver) {
        observers[url]?.removeValue(forKey: ObjectIdentifier(observer))
    }
    
    func retrieveImage(imageUrl: String) {
        if let image = NetworkManager.shared.cache.object(forKey: imageUrl as NSString) {
            notifyObservers(observing: imageUrl, with: image)
            return
        }
        
        guard let url = URL(string: imageUrl) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            guard error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            
            NetworkManager.shared.cache.setObject(image, forKey: imageUrl as NSString)
            self.notifyObservers(observing: imageUrl, with: image)
        }.resume()
    }
    
}


extension ImageManager {
    
    private func notifyObservers(observing url: String, with image: UIImage) {
        if let observers = observers[url] {
            for (_, observer) in observers {
                observer.observer?.imageLoaded(image: image)
            }
        }
    }
    
}
