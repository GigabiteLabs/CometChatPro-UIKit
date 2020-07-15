// UICollectionView+Register+CCPNibs.swift
//
// Created by GigabiteLabs on 7/13/20
// Swift Version: 5.0
// Copyright © 2020 GigabiteLabs. All rights reserved.
//

import Foundation

internal extension UICollectionView {
    /// Registers cell  by `CCNib`.
    func register(_ cometChatProCellType: CCNib) {
        let cellNib: UINib = .sourceNib(cometChatProCellType)
        register(cellNib, forCellWithReuseIdentifier: cometChatProCellType.rawValue)
    }
    /// Dequeues a reusable cell  by `CCNib` for a given `IndexPath`.
    func dequeueReusableCell(with nib: CCNib, for indexPath: IndexPath) -> UICollectionViewCell {
        return dequeueReusableCell(withReuseIdentifier: nib.rawValue, for: indexPath)
    }
}
