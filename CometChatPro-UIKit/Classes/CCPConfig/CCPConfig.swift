// CCPConfig.swift
//
// Created by GigabiteLabs on 7/11/20
// Swift Version: 5.0
// Copyright © 2020 GigabiteLabs. All rights reserved.
//

import Foundation
//@_exported import CometChatPro

public class CCPConfig: CCPType {
    public static var shared = CCPConfig()
    public override init() { }
    /// The
    public var appId: String = ""
    public var apiKey: String = ""
    public var region: String = ""
    public var url: String = "https://api-us.cometchat.io/v2.0/users"
    public var firebaseURL: String = ""
    public var firebasePushURL = "https://fcm.googleapis.com/fcm/send"
    
    public static var userLoggedIn: Bool {
        get {
            let status = UserDefaults.standard.bool(forKey: "CCUserLoggedIn")
            switch status {
            case true:
                return true
            default:
                return false
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "CCUserLoggedIn")
        }
    }
    
    public static var ready: Bool {
        get {
            let status = UserDefaults.standard.bool(forKey: "CCReady")
            switch status {
            case true:
                return true
            default:
                return false
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "CCReady")
        }
    }
}
