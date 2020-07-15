//
//  ViewController.swift
//  CCPMessenger
//
//  Created by DanBurkhardt on 07/11/2020.
//  Copyright (c) 2020 DanBurkhardt. All rights reserved.
//

import UIKit
import UserNotifications
import CCPMessenger
import CometChatPro

class ViewController: UIViewController {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var submit: UIButton!
    
    

    @IBAction func launch(_ sender: Any) {
        getInput()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logo.layer.cornerRadius = logo.frame.height / 2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        registerForNotifications()
        checkLocal()
    }
    
    func getInput() {
        guard let first = firstName.text, !first.isEmpty else {
            message.text = "first name cannot be blank"
            return
        }
        guard let last = lastName.text, !last.isEmpty else {
            message.text = "last name cannot be blank"
            return
        }
        launch(first: first, last: last, uuid: UUID().uuidString)
    }
    
    func checkLocal() {
        guard
            let first = UserDefaults.standard.string(forKey: "first"),
            let last = UserDefaults.standard.string(forKey: "last"),
            let uuid = UserDefaults.standard.string(forKey: "uuid")
        else {
            message.text = "Provide your first and last name to login. This will be the name everyone can see, and you can change it later."
            return
        }
        launch(first: first, last: last, uuid: uuid)
    }
    
    func launch(first: String, last: String, uuid: String) {
        let user: CCPUser = .init(firstname: first, lastname: last, uid: uuid)
        CCPHandler.shared.login(user: user) { (success) in
            switch success {
            case true:
                print("CometChat user login was successful")
                self.presentCometChatPro(.fullScreen, animated: true, completion: nil)
                self.saveLocal(first: first, last: last, uuid: uuid)
            case false:
                print("CometChat user login failed")
            }
        }
    }
    
    func saveLocal(first: String, last: String, uuid: String) {
        UserDefaults.standard.set(first, forKey: "first")
        UserDefaults.standard.set(first, forKey: "last")
        UserDefaults.standard.set(first, forKey: "uuid")
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
