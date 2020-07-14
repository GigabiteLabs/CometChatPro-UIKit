//
//  ViewController.swift
//  CCPMessenger
//
//  Created by DanBurkhardt on 07/11/2020.
//  Copyright (c) 2020 DanBurkhardt. All rights reserved.
//

import UIKit
import CCPMessenger
import UserNotifications
import CometChatPro

class ViewController: UIViewController {

    @IBAction func launch(_ sender: Any) {
        login()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func login() {
        let user: CCPUser = .init(firstname: "iphone", lastname: "dan", uid: "UUID-TEST-2")
        CCPHandler.shared.login(user: user) { (success) in
            switch success {
            case true:
                print("CometChat user login was successful")
                self.presentCometChatPro(.fullScreen, animated: true, completion: nil)
            case false:
                print("CometChat user login failed")
            }
        }
    }
    
    func registerForNotifications() {
        requestNotificationAuthorization { (authorized) in
            print("push notifications authorized?: \(authorized)")
            DispatchQueue.main.async {
                // unlikely that we will not be able to get this ref, but Apple did this, not us
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                    print("could not get reference to AppDelegate, cannot determine status")
                    return
                }
                //CometChat.calldelegate = appDelegate
                CometChatCallManager().registerForCalls(application: appDelegate)
                // register for notifications
                if authorized {
                    UNUserNotificationCenter.current().delegate = appDelegate
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        registerForNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

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
