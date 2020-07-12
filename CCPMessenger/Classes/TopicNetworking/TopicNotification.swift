// TopicNotification.swift
//
// Created by GigabiteLabs on 7/11/20
// Swift Version: 5.0
// Copyright © 2020 GigabiteLabs. All rights reserved.
//

import Foundation

/// TopicNotification
public struct TopicNotification: Codable {
    var title, body, sound: String

    public init(title: String, body: String, sound: String) {
        self.title = title
        self.body = body
        self.sound = sound
    }

    /// TopicNotification convenience initializers and mutators
    init(data: Data) throws {
        self = try CCPJSONCoding.decoder.decode(TopicNotification.self, from: data)
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
        title: String? = nil,
        body: String? = nil,
        sound: String? = nil
    ) -> TopicNotification {
        return TopicNotification(
            title: title ?? self.title,
            body: body ?? self.body,
            sound: sound ?? self.sound
        )
    }

    func jsonData() throws -> Data {
        return try CCPJSONCoding.encoder.encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
