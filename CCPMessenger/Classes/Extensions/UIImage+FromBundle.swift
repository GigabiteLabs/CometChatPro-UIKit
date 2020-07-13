//
//  UIImage+Extensions.swift
//  GBLTasks
//
//  Created by Dan on 4/16/20.
//

import Foundation

internal extension UIImage {
    class func fromBundle(named imageName: String) -> UIImage {
        let bundle = Bundle(for: CCPType.self).podResource(name: "CCPMessenger")
        let img = UIImage(named: imageName, in: bundle, compatibleWith: nil)!
        return img
    }
}
