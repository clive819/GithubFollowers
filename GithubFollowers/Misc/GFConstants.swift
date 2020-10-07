//
//  GFConstants.swift
//  GithubFollowers
//
//  Created by Clive Liu on 10/4/20.
//

import UIKit


enum Assets {
    static let logo = UIImage(named: "gh-logo")
    static let emptyStateLogo = UIImage(named: "empty-state-logo")
    static let avatarPlaceholder = UIImage(named: "avatar-placeholder")
}


enum SFSymbols {
    static let pin = UIImage(systemName: "mappin.and.ellipse")
    static let repo = UIImage(systemName: "folder")
    static let gist = UIImage(systemName: "text.alignleft")
    static let followers = UIImage(systemName: "heart")
    static let followering = UIImage(systemName: "person.2")
    static let favorite = UIImage(systemName: "star")
}


enum ScreenSize {
    static let width        = UIScreen.main.bounds.size.width
    static let height       = UIScreen.main.bounds.size.height
    static let maxLength    = max(ScreenSize.width, ScreenSize.height)
    static let minLength    = min(ScreenSize.width, ScreenSize.height)
}


enum DeviceTypes {
    static let idiom                    = UIDevice.current.userInterfaceIdiom
    static let nativeScale              = UIScreen.main.nativeScale
    static let scale                    = UIScreen.main.scale

    static let isiPhoneSE               = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone8Standard        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed          = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard    = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed      = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isiPhoneX                = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr       = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad                   = idiom == .pad && ScreenSize.maxLength >= 1024.0

    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }
}
