// CCPTopic.swift
//
// Created by GigabiteLabs on 7/11/20
// Swift Version: 5.0
// Copyright © 2020 GigabiteLabs. All rights reserved.
//

import Foundation

public class CCPTopicPush: CCPType {
    public var topicString: String
    public var body: String
    public var senderName: String
    public var headers: [String : String]
    
    public init(topicString: String, body: String, senderName: String, authString: String) {
        self.topicString = topicString
        self.body = body
        self.senderName = senderName
        self.headers = ["Authorization" : authString, "Content-Type" : "application/json"]
    }
}
