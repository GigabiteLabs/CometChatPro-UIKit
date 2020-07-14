//
//  AppDelegate.swift
//  CCPMessenger
//
//  Created by DanBurkhardt on 07/11/2020.
//  Copyright (c) 2020 DanBurkhardt. All rights reserved.
//

import UIKit
import CCPMessenger
import CometChatPro
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        configCometChat()
        return true
    }
    
    func configCometChat() {
        // Override point for customization after application launch.
        CCPConfig.shared.apiKey = "e42664b7cd8a1ca4df5afcb42d459b22c1571880"
        CCPConfig.shared.appId = "21075774089df29"
        CCPConfig.shared.region = "US"
        let user: CCPUser = .init(firstname: "test", lastname: "dan", uid: "UUID-TEST")
        let mySettings = AppSettings.AppSettingsBuilder().subscribePresenceForAllUsers().setRegion(region: CCPConfig.shared.region).build()
        let _ = CometChat(appId: CCPConfig.shared.appId,appSettings: mySettings,onSuccess: { (isSuccess) in
        if (isSuccess) {
            print("Chat intialized successfully.")
            CCPHandler.shared.login(user: user) { (success) in
                switch success {
                case true:
                    print("CometChat user login was successful")
                    CometChat.calldelegate = self
                case false:
                    print("CometChat user login failed")
                }
            }
        } }){(error) in print("Chat failed intialise with error: \(error.errorDescription)") }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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
       print(#function)
       if let currentCall = incomingCall {
           DispatchQueue.main.async {
               let call = CometChatIncomingCall()
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
       print(#function)
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
       print(#function)
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
       print(#function)
       if let call = canceledCall {
           CometChatCallManager.incomingCallDelegate?.onIncomingCallCancelled(canceledCall: call, error: error)
       }
   }
}

