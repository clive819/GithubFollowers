//
//  Follower.swift
//  GithubFollowers
//
//  Created by Clive Liu on 10/4/20.
//

import Foundation


struct Follower: Codable, Hashable {
    let login: String
    let avatarUrl: String
}
