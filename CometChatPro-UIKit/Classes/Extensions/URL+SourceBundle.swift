// URL+SourceBundle.swift
//
// Created by GigabiteLabs on 7/14/20
// Swift Version: 5.0
// Copyright © 2020 GigabiteLabs. All rights reserved.
//

import Foundation

internal extension URL {
    static func sourceBundle(_ audioFileName: CCAudioFileName) -> URL {
        let bundle = Bundle(for: CCPType.self).podResource(name: "CometChatPro-UIKit")
        let url = bundle.bundleURL.appendingPathComponent(audioFileName.withExtension)
        return url
    }
}
