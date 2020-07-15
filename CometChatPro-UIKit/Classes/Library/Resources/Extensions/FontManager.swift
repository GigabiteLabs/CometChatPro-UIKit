//
//  FontManager.swift
//  Demo
//
//  Created by CometChat Inc. on 16/12/19.
//  Copyright © 2020 CometChat Inc. All rights reserved.
//
import UIKit

internal extension UIFont {
    /// Loads all `UIFont` files for the framework and registers them with the framework's bundle.
    class func loadCometChatFonts() {
        let bundleIdentifierString = CCPType.bundleId
        registerFontWithFilenameString(filenameString: "SF-Pro-Display-Regular.otf", bundleIdentifierString: bundleIdentifierString)
        registerFontWithFilenameString(filenameString: "SF-Pro-Display-RegularItalic.otf", bundleIdentifierString: bundleIdentifierString)
        registerFontWithFilenameString(filenameString: "SF-Pro-Display-Medium.otf", bundleIdentifierString: bundleIdentifierString)
        registerFontWithFilenameString(filenameString: "SF-Pro-Display-Bold.otf", bundleIdentifierString: bundleIdentifierString)
        registerFontWithFilenameString(filenameString: "SF-Pro-Display-Black.otf", bundleIdentifierString: bundleIdentifierString)
    }
    
    static func registerFontWithFilenameString(filenameString: String, bundleIdentifierString: String) {
        if let frameworkBundle = Bundle(identifier: bundleIdentifierString) {
            let pathForResourceString = frameworkBundle.path(forResource: filenameString, ofType: nil)
            if let path = pathForResourceString {
                guard let fontData = NSData(contentsOfFile: path) else { return  }
                guard let dataProvider = CGDataProvider(data: fontData) else { return }
                guard let fontRef = CGFont(dataProvider) ?? nil else { return }
                var errorRef: Unmanaged<CFError>? = nil
                if (CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) == false) {
                    print("Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
                } else {
                    print("registered font: \(filenameString)")
                }
                
            }
        }
        else {
            print("Failed to register font - bundle identifier invalid.")
        }
    }
}
