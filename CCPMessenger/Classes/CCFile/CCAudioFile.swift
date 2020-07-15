// CCAudioFile.swift
//
// Created by GigabiteLabs on 7/14/20
// Swift Version: 5.0
// Copyright © 2020 GigabiteLabs. All rights reserved.
//

import Foundation

@objc internal enum CCAudioFileName: Int, CaseIterable {
    typealias RawValue = Int
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
        return "\(self.filename).wav"
    }
    internal var filename: String {
        switch self {
        case .IncomingCall:
            return "IncomingCall"
        case .IncomingMessage:
            return "IncomingMessage"
        case .IncomingMessageOther:
            return "IncomingMessageOther"
        case .NewAnnouncement:
            return "NewAnnouncement"
        case .OutgoingCall:
            return "OutgoingCall"
        case .OutgoingMessage:
            return "OutgoingMessage"
        }
    }
}
