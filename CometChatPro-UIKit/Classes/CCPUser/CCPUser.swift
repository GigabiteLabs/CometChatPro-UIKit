// CCPUser.swift
//
// Created by GigabiteLabs on 7/11/20
// Swift Version: 5.0
// Copyright © 2020 GigabiteLabs. All rights reserved.
//

import Foundation

public class CCPUser: CCPType {
    public var firstname: String
    public var lastname: String
    public var uid: String
    public var profilePhoto: String?
    public var bio: String?
    public init (firstname: String, lastname: String, uid: String) {
        self.firstname = firstname
        self.lastname = lastname
        self.uid = uid
    }
}
