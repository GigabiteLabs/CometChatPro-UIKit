// CCPHandler+Subscriptions.swift
//
// Created by GigabiteLabs on 7/11/20
// Swift Version: 5.0
// Copyright © 2020 GigabiteLabs. All rights reserved.
//

import Foundation
import CometChatPro
import FirebaseMessaging

public extension CCPHandler {
    func subscribeTo(topic: String){
        print("attempting to subscribe user to topic: \(topic)")
        // Subscribe to comet chat push notifications through Firebase
        Messaging.messaging().subscribe(toTopic: topic) { error in
            if error == nil {
                print("subscribed CometChat user to topic: \(topic)")
                return
            }
            print("attempt to subscribe CometChat user to topic \(topic) failed: \(error?.localizedDescription ?? "(no error provided)")")
        }
    }

    func unSubscribe(topic: String){
        // Subscribe to comet chat push notifications through Firebase
        Messaging.messaging().unsubscribe(fromTopic: topic) { error in
            if error == nil {
                print("unsubscribed CometChat user from topic: \(topic)")
                return
            }
            print("attempt to unsibscribe user from topic \(topic) failed: \(error?.localizedDescription ?? "(no error provided)")")
        }
    }
}
