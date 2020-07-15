// CCPType.swift
//
// Created by GigabiteLabs on 7/11/20
// Swift Version: 5.0
// Copyright © 2020 GigabiteLabs. All rights reserved.
//

import Foundation

public class CCPType {
    /// Returns the `Bundle` of the class
    public static var bundle: Bundle {
        let bundle = Bundle(for: self.self).podResource(name: "CometChatPro-UIKit")
        return bundle
    }
    /// Returns the `Bundle` of the class
    public static var bundleId: String {
        return self.bundle.bundleIdentifier!
    }
}
