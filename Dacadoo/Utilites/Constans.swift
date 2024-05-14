//
//  Constans.swift
//  Dacadoo
//
//  Created by Pajaziti Labinot on 14.5.24..
//

import UIKit

enum PhotoLoadingError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case invalidData
    case decodingError(Error)
}

enum Images {
    static let ghLogo = UIImage(named: "dacadoo-logo")
    static let placeHolder =  UIImage(named: "avatar-placeholder")
    static let emptyState = UIImage(named: "empty-state-logo")
}

enum ScreenSize {
    static let width                        = UIScreen.main.bounds.size.width
    static let height                       = UIScreen.main.bounds.size.height
    static let maxLength                    = max(ScreenSize.width, ScreenSize.height)
    static let minLength                    = min(ScreenSize.width, ScreenSize.height)
}

enum DeviceType {
    static let idiom                        = UIDevice.current.userInterfaceIdiom
    static let nativeScale                  = UIScreen.main.nativeScale
    static let scale                        = UIScreen.main.scale
    
    static let isiPhoneSE                   = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone8Standard            = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed              = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard        = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed          = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isiPhoneX                    = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr           = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPhone11                   = idiom == .phone && ScreenSize.maxLength == 896.0 && nativeScale == scale
    static let isiPhone11Pro                = idiom == .phone && ScreenSize.maxLength == 812.0 && nativeScale == scale
    static let isiPhone11ProMax             = idiom == .phone && ScreenSize.maxLength == 896.0 && nativeScale == scale
    static let isiPhone12Mini               = idiom == .phone && ScreenSize.maxLength == 812.0 && nativeScale == scale
    static let isiPhone12                   = idiom == .phone && ScreenSize.maxLength == 844.0 && nativeScale == scale
    static let isiPhone12Pro                = idiom == .phone && ScreenSize.maxLength == 844.0 && nativeScale == scale
    static let isiPhone12ProMax             = idiom == .phone && ScreenSize.maxLength == 926.0 && nativeScale == scale
    static let isiPhone13Mini               = idiom == .phone && ScreenSize.maxLength == 780.0 && nativeScale == scale
    static let isiPhone13                   = idiom == .phone && ScreenSize.maxLength == 844.0 && nativeScale == scale
    static let isiPhone13Pro                = idiom == .phone && ScreenSize.maxLength == 844.0 && nativeScale == scale
    static let isiPhone13ProMax             = idiom == .phone && ScreenSize.maxLength == 926.0 && nativeScale == scale
    static let isiPhoneSE2                  = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPad                       = idiom == .pad && ScreenSize.maxLength == 1024.0
    
    static func isiPhoneXAscetRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr || isiPhone11 || isiPhone11Pro || isiPhone11ProMax || isiPhone12Mini || isiPhone12 || isiPhone12Pro || isiPhone12ProMax || isiPhone13Mini || isiPhone13 || isiPhone13Pro || isiPhone13ProMax || isiPhoneSE2
    }
}
