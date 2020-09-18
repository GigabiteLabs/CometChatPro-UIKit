// CCPMessageCell.swift
//
// Created by GigabiteLabs on 7/15/20
// Swift Version: 5.0
// Copyright © 2020 GigabiteLabs. All rights reserved.
//

import UIKit
import WebKit
import AVKit
import AVFoundation
import Foundation
import CometChatPro

internal class CCPMediaMessageCell: UITableViewCell {
    var file: MediaMessage!
    var textMsg: TextMessage?
    var linkPreviewMsg: TextMessage!
    var imageMsg: MediaMessage!
    
    
    /// A computed property that returns the mediatype for a `CCPMediaMessageCell`
    var mediaType: CCPMediaType? {
        print("comparing classname: \(type(of: self).className)")
        switch type(of: self).className {
        case LeftFileMessageBubble.className , RightFileMessageBubble.className:
            return .file
        case LeftVideoMessageBubble.className, RightVideoMessageBubble.className:
            return .video
        case LeftAudioMessageBubble.className, RightAudioMessageBubble.className:
            return .audio
        case LeftTextMessageBubble.className, RightTextMessageBubble.className:
            return .text
        case LeftLinkPreviewBubble.className, RightLinkPreviewBubble.className:
            return .link
        case LeftImageMessageBubble.className, RightImageMessageBubble.className:
            return .image
        default:
            print("unknown class type")
            return nil
        }
    }
    
}
