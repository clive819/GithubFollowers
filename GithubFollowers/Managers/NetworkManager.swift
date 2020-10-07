//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Clive Liu on 10/4/20.
//

import UIKit


class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let baseUrl = "https://api.github.com/users/"
    
    let cache = NSCache<NSString, UIImage>()
    
    var numResultsPerPage = 100
    
    
    private init(){}
    
    func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], GFError>) -> Void)  {
        let endpoint = baseUrl + "\(username)/followers?per_page=\(numResultsPerPage)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completion(.success(followers))
            }catch {
                completion(.failure(.invalidData))
            }
        }.resume()
    }
    
    func getUserInfo(for username: String, completion: @escaping (Result<User, GFError>) -> Void)  {
        let endpoint = baseUrl + "\(username)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(User.self, from: data)
                completion(.success(user))
            }catch {
                completion(.failure(.invalidData))
            }
        }.resume()
    }
    
}
