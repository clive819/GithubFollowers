//
//  User.swift
//  GithubFollowers
//
//  Created by Clive Liu on 10/4/20.
//

import Foundation


struct User: Codable {
    let login: String
    let avatarUrl: String
    let htmlUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int
    let createdAt: Date
}
