// AppDelegate+CometChatCallDelegate.swift
//
// Created by GigabiteLabs
// Swift Version: 5.0
// Copyright © 2020 GigabiteLabs. All rights reserved.
//

import Foundation
import CometChatPro
import CCPMessenger

extension AppDelegate: CometChatCallDelegate {
   /**
   This method triggers when incoming call received from Server.
    - Parameters:
     - incomingCall: Specifies a Call Object
       - error:  triggers when error occurs
   - Author: CometChat Team
   - Copyright:  ©  2020 CometChat Inc.
   */
   func onIncomingCallReceived(incomingCall: Call?, error: CometChatException?) {
       print("incoming call recieved")
       if let currentCall = incomingCall {
           DispatchQueue.main.async {
            let call: CometChatIncomingCall = .fromCometChatNib(.CometChatIncomingCall)
               call.modalPresentationStyle = .custom
               call.setCall(call: currentCall)
               if let window = self.window, let rootViewController = window.rootViewController {
                   var currentController = rootViewController
                   while let presentedController = currentController.presentedViewController {
                       currentController = presentedController
                   }
                   currentController.present(call, animated: true, completion: nil)
               }
               if let call = incomingCall {
                   CometChatCallManager.incomingCallDelegate?.onIncomingCallReceived(incomingCall: call, error: error)
               }
           }
       }

   }
   /**
   This method triggers when outgoing call accepted from User or group.
    - Parameters:
     - acceptedCall: Specifies a Call Object
       - error:  triggers when error occurs
   - Author: CometChat Team
   - Copyright:  ©  2020 CometChat Inc.
   */
   func onOutgoingCallAccepted(acceptedCall: Call?, error: CometChatException?) {
       print("outgoing call accepted")
       if let call = acceptedCall {
           CometChatCallManager.outgoingCallDelegate?.onOutgoingCallAccepted(acceptedCall: call, error: error)
       }
   }
   /**
   This method triggers when ourgoing call rejected from User or group.
    - Parameters:
     - rejectedCall: Specifies a Call Object
       - error:  triggers when error occurs
   - Author: CometChat Team
   - Copyright:  ©  2020 CometChat Inc.
   */
   func onOutgoingCallRejected(rejectedCall: Call?, error: CometChatException?) {
       print("outgoing call rejected")
       if let call = rejectedCall {
           CometChatCallManager.outgoingCallDelegate?.onOutgoingCallRejected(rejectedCall: call, error: error)
       }
   }
   /**
   This method triggers when incoming call cancelled from User or group.
    - Parameters:
     - rejectedCall: Specifies a Call Object
       - error:  triggers when error occurs
   - Author: CometChat Team
   - Copyright:  ©  2020 CometChat Inc.
   */
   func onIncomingCallCancelled(canceledCall: Call?, error: CometChatException?) {
       print("incoming call cancelled")
       if let call = canceledCall {
           CometChatCallManager.incomingCallDelegate?.onIncomingCallCancelled(canceledCall: call, error: error)
       }
   }
}
