// TopicPushPayload.swift
//
// Created by GigabiteLabs
// Swift Version: 5.0
// Copyright © 2020 GigabiteLabs. All rights reserved.
//

import Foundation

/// TopicPayload
public struct TopicPayload: Codable {
    public var to: String
    public var notification: TopicNotification
    public var contentAvailable: Bool
    
    enum CodingKeys: String, CodingKey {
        case to
        case notification = "notification"
        case contentAvailable = "content_available"
    }
    
    public init(to: String, notification: TopicNotification, contentAvailable: Bool) {
        self.to = to
        self.notification = notification
        self.contentAvailable = contentAvailable
    }

    init(data: Data) throws {
        self = try CCPJSONCoding.decoder.decode(TopicPayload.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        to: String? = nil,
        notification: TopicNotification? = nil,
        contentAvailable: Bool? = nil
    ) -> TopicPayload {
        return TopicPayload(
            to: to ?? self.to,
            notification: notification ?? self.notification,
            contentAvailable: contentAvailable ?? self.contentAvailable
        )
    }

    func jsonData() throws -> Data {
        return try CCPJSONCoding.encoder.encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
