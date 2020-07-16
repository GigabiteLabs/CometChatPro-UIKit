// URL+UTTypeIdentifier.swift
//
// Created by GigabiteLabs on 7/16/20
// Swift Version: 5.0
// Copyright © 2020 GigabiteLabs. All rights reserved.
//

import Foundation
import MobileCoreServices

extension URL {
    var typeIdentifier: String? {
        let unmanagedUTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as CFString, nil)
        if let fileUTI = unmanagedUTI?.takeRetainedValue() {
            return String(fileUTI)
        }
        return nil
    }
    var localizedName: String? {
        return path.components(separatedBy: "/").last
    }
}
