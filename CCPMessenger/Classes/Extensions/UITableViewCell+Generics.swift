// UITableViewCell+Generics.swift
//
// Created by GigabiteLabs on 7/11/20
// Swift Version: 5.0
// Copyright © 2020 GigabiteLabs. All rights reserved.
//

import Foundation

internal extension UITableViewCell {
    /// Returns Nib of the cell for use in `UITableView` registration events
    class func sourceNib(_ name: CCPNibs) -> UINib {
        let bundle = Bundle(for: CCPType.self).podResource(name: "CCPMessenger")
        print("bundle for NIB: \(bundle)")
        print("resourcePath: \(bundle.resourcePath)")
        do {
            let contents = try FileManager.default.contentsOfDirectory(atPath: bundle.bundlePath)
            print(contents)
        } catch {
            print(error)
        }
        let nib = UINib(nibName: name.rawValue, bundle: bundle)
        return nib
    }
}
