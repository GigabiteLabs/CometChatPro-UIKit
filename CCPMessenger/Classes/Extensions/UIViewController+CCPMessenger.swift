// UIViewController+CCPMessenger.swift
//
// Created by GigabiteLabs on 7/11/20
// Swift Version: 5.0
// Copyright © 2020 GigabiteLabs. All rights reserved.
//

import Foundation

/// An extension for `UIViewController` that allows for easy presentaion
/// of the `CometChatUnified` view controller from any VC context.
extension UIViewController {
    /// Allows presentation by either automatic detection of device type, or an explicitly
    /// provided presentation style.
    ///
    /// - Parameters:
    ///     - withStyle: An optional type for `UIModalPresentationStyle`.
    ///     If none is provided, the default will be used for the current device type.
    ///
    /// - Note:
    ///
    ///     - Default style for iPhone is `.popover`
    ///     - Default style for iPad is `.formSheet`
    ///
    public func presentCometChatPro(_ withStyle: UIModalPresentationStyle?, animated: Bool, completion: (() -> Void)?) {
        guard let withStyle = withStyle else {
            presentWithDefaultPresentationStyle(animated: animated, completion: completion)
            return
        }
        let unified = CometChatUnified()
        unified.setup(withStyle: withStyle)
        present(unified, animated: animated, completion: completion)
    }
    /// Returns an instance of the `CometChatUnified` view controller. The view controller
    /// will be setup with the style option, if one is provided.
    ///
    /// - Parameters:
    ///     - setupWithStyle: An optional type for `UIModalPresentationStyle`.
    ///
    /// - Note:
    ///     If no style option is provided, the view controller will not be setup for any particular style and
    ///     the application will have to customize before presentation.
    ///
    /// Example:
    ///
    ///         // return with no style
    ///         let ccPro = getCometChatPro()
    ///         ccPro.setup(withStyle: .popover) // manually setup
    ///         present(ccPro, animated: true)
    ///
    ///         // return with provided style
    ///         let ccPro = getCometChatPro(.popover)
    ///         present(ccPro, animated: true) // automatically setup
    ///
    public func getCometChatPro(_ setupWithStyle: UIModalPresentationStyle?) -> CometChatUnified {
        // return non-setup if not specified
        guard let setupWithStyle = setupWithStyle else {
            return CometChatUnified()
        }
        // setup & return
        let unified = CometChatUnified()
        unified.setup(withStyle: setupWithStyle)
        return unified
    }
    /// Fileprivate utility to present with a default style
    /// based on `UIDevice.current.userInterfaceIdiom`.
    fileprivate func presentWithDefaultPresentationStyle(animated: Bool, completion: (() -> Void)?) {
        // init
        let cometChatUnified = CometChatUnified()
        // setup
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            cometChatUnified.setup(withStyle: .formSheet)
        default:
            cometChatUnified.setup(withStyle: .popover)
        }
        // present
        present(cometChatUnified, animated: animated, completion: completion)
    }
}
