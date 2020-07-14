// CCAudioFile.swift
//
// Created by GigabiteLabs on 7/14/20
// Swift Version: 5.0
// Copyright © 2020 GigabiteLabs. All rights reserved.
//

import Foundation

internal enum CCAudioFileName: String, CaseIterable {
    case IncomingCall
    case IncomingMessage
    case IncomingMessageOther
    case NewAnnouncement
    case OutgoingCall
    case OutgoingMessage
    /// Returns a `String` value `wav`, the  filetype for all audio files.
    internal static var filetype: String {
        return "wav"
    }
    /// Returns a `String` value  of the type with`.wav` appended.
    internal var withExtension: String {
        return "\(self.rawValue).wav"
    }
}
