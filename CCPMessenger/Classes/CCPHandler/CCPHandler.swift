// CCPHandler.swift
//
// Created by GigabiteLabs on 7/11/20
// Swift Version: 5.0
// Copyright © 2020 GigabiteLabs. All rights reserved.
//

import Foundation
import CometChatPro
import FirebaseMessaging

public final class CCPHandler: CCPType {
    public static let shared = CCPHandler()
    private override init() { }
}

internal extension URLRequest {
    private func percentEscapeString(_ string: String) -> String {
        var characterSet = CharacterSet.alphanumerics
        characterSet.insert(charactersIn: "-._* ")
        return string
            .addingPercentEncoding(withAllowedCharacters: characterSet)!
            .replacingOccurrences(of: " ", with: "+")
            .replacingOccurrences(of: " ", with: "+", options: [], range: nil)
    }
    mutating func encodeParameters(parameters: [String : String]) {
        httpMethod = "POST"

        let parameterArray = parameters.map { (arg) -> String in
            let (key, value) = arg
            return "\(key)=\(self.percentEscapeString(value))"
        }
        httpBody = parameterArray.joined(separator: "&").data(using: String.Encoding.utf8)
    }
}
