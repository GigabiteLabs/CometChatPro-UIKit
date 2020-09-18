// UITableViewCell+ClassName.swift
//
// Created by GigabiteLabs on 7/15/20
// Swift Version: 5.0
// Copyright © 2020 GigabiteLabs. All rights reserved.
//

import Foundation

extension UITableViewCell {
    static var className: String {
        print("with className: \(String(describing: self))")
        return String(describing: self)
    }
}
