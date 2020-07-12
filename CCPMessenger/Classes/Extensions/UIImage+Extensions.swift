//
//  UIImage+Extensions.swift
//  GBLTasks
//
//  Created by Dan on 4/16/20.
//

import Foundation

internal extension UIImage {
    @available(iOS 13.0, *)
    class func fromBundle(named imageName: String) -> UIImage {
        let bundle = Bundle(for: CCPType.self).podResource(name: "CCPMessenger")
        print("bundle for image: \(bundle)")
        do {
            let contents = try FileManager.default.contentsOfDirectory(atPath: bundle.bundlePath)
            print(contents)
        } catch {
            print(error)
        }
        let img = UIImage(named: imageName, in: bundle, compatibleWith: nil)!
        print("img: \(img)")
        return img
    }
}

internal extension Bundle {
    func podResource(name: String) -> Bundle {
        guard let bundleUrl = self.url(forResource: name, withExtension: "bundle") else { return self }
        return Bundle(url: bundleUrl) ?? self
    }
}
