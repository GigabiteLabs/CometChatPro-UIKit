// UICollectionViewCell+Generics.swift
//
// Created by GigabiteLabs on 7/12/20
// Swift Version: 5.0
// Copyright © 2020 GigabiteLabs. All rights reserved.
//

import Foundation

internal extension UICollectionViewCell {
    /// Returns Nib of the cell 
    class func sourceNib(_ name: CCNib) -> UINib {
        let bundle = Bundle(for: CCPType.self).podResource(name: "CCPMessenger")
        let nib = UINib(nibName: name.rawValue, bundle: bundle)
        return nib
    }
}
