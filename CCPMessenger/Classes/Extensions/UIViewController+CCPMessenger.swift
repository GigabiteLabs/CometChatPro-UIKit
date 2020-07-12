// UIViewController+CCPMessenger.swift
//
// Created by GigabiteLabs on 7/11/20
// Swift Version: 5.0
// Copyright © 2020 GigabiteLabs. All rights reserved.
//

import Foundation

extension UIViewController {
    public func presentCCPMessenger() {
        let cometChatUI = CometChatUnified()
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            cometChatUI.setup(withStyle: .formSheet)
            present(cometChatUI, animated: true) {
                print("CometChat Presented")
            }
        default:
            cometChatUI.setup(withStyle: .popover)
            present(cometChatUI, animated: true) {
                print("CometChat Presented")
            }
        }
    }
    
    public func getCCPMessenger() -> CometChatUnified {
       return CometChatUnified()
    }
}
