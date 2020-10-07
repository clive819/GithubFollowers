//
//  PersistenceManager.swift
//  GithubFollowers
//
//  Created by Clive Liu on 10/5/20.
//

import Foundation


enum PersistenceActionType {
    case add, remove
}


enum PersistenceManager {

    private enum Keys { static let favorites = "favorites" }
    
    private static let dafaults = UserDefaults.standard

    
    static func update(with favorite: Follower, actionType: PersistenceActionType, completion: @escaping (GFError?) -> Void) {
        retrieveFavorites { (result) in
            switch result {
            case .success(var favorites):
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        completion(.alreadyInFavorites)
                        return
                    }
                    favorites.append(favorite)
                    
                case .remove:
                    favorites.removeAll(where: {$0.login == favorite.login})
                }
                
                completion(save(favorites: favorites))
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    static func retrieveFavorites(completion: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let data = dafaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: data)
            completion(.success(favorites))
        }catch {
            completion(.failure(.unableToLoadFavorites))
        }
    }
    
    static func save(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let data  = try encoder.encode(favorites)
            dafaults.setValue(data, forKey: Keys.favorites)
        }catch {
            return .unableToFavorite
        }
        return nil
    }
    
}
