// CCPHandler+Push.swift
//
// Created by GigabiteLabs on 7/11/20
// Swift Version: 5.0
// Copyright © 2020 GigabiteLabs. All rights reserved.
//

import Foundation

public extension CCPHandler {
    func sendTopicPush(topicPush: CCPTopicPush, config: CCPConfig,  completion: @escaping (PushResponse?)->Void){
        let notification: TopicNotification = TopicNotification(title: topicPush.senderName, body: topicPush.body, sound: "recieved.mp3")
        let topicPayload: TopicPayload = TopicPayload(to: "/topics/\(topicPush.topicString)", notification: notification, contentAvailable: true)
        let headers: [String : String] = topicPush.headers
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted]
            let encoded = try encoder.encode(topicPayload)
            guard let jsonString = String(data: encoded, encoding: .utf8)?.replacingOccurrences(of: "\\/", with: "/") else {
                print("jsonString was nil")
                completion(nil)
                return
            }
            print("string body for notification: \(jsonString)")
            PushEndpoint(config: config).sendRequest(url: config.firebasePushURL, method: .POST, body: jsonString, customHeaders: headers) { (pushResponse) in
                guard pushResponse != nil else {
                    print("response returned nil")
                    completion(nil)
                    return
                }
                print("topic returned response: \(pushResponse.debugDescription)")
                completion(pushResponse)
            }
        }catch{
            print("could not encode topicPayload: \(error)")
            completion(nil)
        }
    }

}
