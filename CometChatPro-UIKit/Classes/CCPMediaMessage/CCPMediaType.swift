// CCPMediaMessageType.swift
//
// Created by GigabiteLabs on 7/15/20
// Swift Version: 5.0
// Copyright © 2020 GigabiteLabs. All rights reserved.
//

import Foundation

/// An Enum representing all supported media types
enum CCPMediaType {
    /// A media type representing a `String`
    case text
    /// A media type representing an openable link.
    case link
    /// A media type representing an image file.
    case image
    /// A media type representing a file of any type.
    case file
    /// A media type representing an video file.
    case video
    /// A media type representing an audio file.
    case audio
    /// Returns the `String` description of the mediaType
    var description: String {
        switch self {
        case .text:
            return "text"
        case .link:
            return "link"
        case .image:
            return "image"
        case .file:
            return "file"
        case .video:
            return "video"
        case .audio:
            return "audio"
        }
    }
}
