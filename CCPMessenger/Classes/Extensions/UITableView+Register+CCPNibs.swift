// UITableView+Register+CCPNibs.swift
//
// Created by GigabiteLabs on 7/13/20
// Swift Version: 5.0
// Copyright © 2020 GigabiteLabs. All rights reserved.
//

import Foundation

internal extension UITableView {
    /// 
    func register(_ cometChatProCellType: CCPNibs) {
        let cellNib: UINib = .sourceNib(cometChatProCellType)
        register(cellNib, forCellReuseIdentifier: cometChatProCellType.rawValue)
    }
}
