//
//  GFError.swift
//  GithubFollowers
//
//  Created by Clive Liu on 10/4/20.
//

import Foundation


enum GFError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server is corrupted. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case unableToLoadFavorites = "An error occured while loading favorites. Please try again."
    case unableToFavorite = "An error occured while saving favorites. Please try again."
    case alreadyInFavorites = "This user is already in your favorites list."
}
