// UIViewController+Generics.swift
//
// Created by GigabiteLabs on 7/12/20
// Swift Version: 5.0
// Copyright © 2020 GigabiteLabs. All rights reserved.
//

import Foundation

public extension UIViewController {
    /// Returns Nib of the cell
    internal class func sourceNib(_ name: CCNib) -> UINib {
        let bundle = Bundle(for: CCPType.self).podResource(name: "CCPMessenger")
        let nib = UINib(nibName: name.rawValue, bundle: bundle)
        return nib
    }
    class func fromCometChatNib<T: UIViewController>(_ nibName: CCNib) -> T {
        let bundle = Bundle(for: CCPType.self).podResource(name: "CCPMessenger")
        return T(nibName: nibName.rawValue, bundle: bundle)
    }
}
