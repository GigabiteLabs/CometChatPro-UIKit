//  CometChatSoundManager.swift
//  CometChatUIKit
//  Created by CometChat Inc. on 20/09/19.
//  Copyright ©  2020 CometChat Inc. All rights reserved.

// MARK: - Importing Frameworks.

import Foundation
import AVFoundation

// MARK: - Declaration of Enum

public enum Sound: String {
    case incomingCall
    case incomingMessage
    case incomingMessageForOther
    case outgoingCall
    case outgoingMessage
}

// MARK: - Declaration of Public variable

public var audioPlayer: AVAudioPlayer?

/*  ----------------------------------------------------------------------------------------- */

public final class CometChatSoundManager: NSObject {
    
    /**
       This method play or pause different types of sounds for incoming outgoing calls and messages.
         - Parameters:
            - sound: Specifies an enum of Sound Types such as incomingCall, incomingMessage etc.
            - pausingCurrentlyPlayingAudio: if set to true, pauses any currently playing audio
       - Author: CometChat Team
       - Copyright:  ©  2020 CometChat Inc.
       */
    public func play(sound: Sound, pausingCurrentlyPlayingAudio: Bool) throws {
       if pausingCurrentlyPlayingAudio == true {
       switch sound {
        case .incomingCall:
            let soundURL: URL = .sourceBundle(.IncomingCall)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
            try AVAudioSession.sharedInstance().setActive(true)
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        case .incomingMessage:
            let soundURL: URL = .sourceBundle(.IncomingMessage)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
            try AVAudioSession.sharedInstance().setActive(true)
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        case .outgoingCall:
            let soundURL: URL = .sourceBundle(.OutgoingCall)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
            try AVAudioSession.sharedInstance().setActive(true)
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        case .outgoingMessage:
            let soundURL: URL = .sourceBundle(.OutgoingMessage)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
            try AVAudioSession.sharedInstance().setActive(true)
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        case .incomingMessageForOther:
            let soundURL: URL = .sourceBundle(.IncomingMessageOther)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
            try AVAudioSession.sharedInstance().setActive(true)
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        }
        }else{
        if audioPlayer?.isPlaying == true {
            audioPlayer?.pause()
            }
        }
    }
}

/*  ----------------------------------------------------------------------------------------- */
