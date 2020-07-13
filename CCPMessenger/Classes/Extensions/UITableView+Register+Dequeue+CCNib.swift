// UITableView+Register+CCPNibs.swift
//
// Created by GigabiteLabs on 7/13/20
// Swift Version: 5.0
// Copyright © 2020 GigabiteLabs. All rights reserved.
//

import Foundation

internal extension UITableView {
    /// Registers a `UITableViewCell` by `CCNib`
    func register(_ cometChatProCellType: CCNib) {
        let cellNib: UINib = .sourceNib(cometChatProCellType)
        register(cellNib, forCellReuseIdentifier: cometChatProCellType.rawValue)
    }
    /// Dequeues a reusable calle by `CCNib` for a given `IndexPath`.
    func dequeReusableCell(with nib: CCNib, for indexPath: IndexPath) -> UITableViewCell {
        return dequeueReusableCell(withIdentifier: nib.rawValue, for: indexPath)
    }
}
