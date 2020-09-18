//
//  AppDelegate.swift
//  CCPMessenger
//
//  Created by DanBurkhardt on 07/11/2020.
//  Copyright (c) 2020 DanBurkhardt. All rights reserved.
//

import UIKit
@_exported import CometChatPro
import CometChatPro_UIKit
import FirebaseCore
import FirebaseMessaging
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        configureIQKeyboard()
        configFirebase()
        configCometChat()
        CometChat.calldelegate = self
        return true
    }
    
    func configureIQKeyboard() {
        // Configure IQKeyboard
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().isEnableAutoToolbar = false
        IQKeyboardManager.shared().shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
    }
    
    func configFirebase() {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
    }
    
    func configCometChat() {
        // Override point for customization after application launch.
        let env = ProcessInfo.processInfo.environment
        guard
            let ccAPIKey = env["CCAPIKey"],
            let ccAppID = env["CCAppID"],
            let ccAppRegion = env["CCAppRegion"]
        else {
            fatalError("ERROR: One or more environment variables for CometChat config were nil. Reference README.MD for configuration instructions.")
        }
        
        // configure for your account
        CCPConfig.shared.apiKey = ccAPIKey
        CCPConfig.shared.appId = ccAppID
        CCPConfig.shared.region = ccAppRegion
        
        // all CometChatPro's config builder
        let mySettings = AppSettings.AppSettingsBuilder().subscribePresenceForAllUsers().setRegion(region: CCPConfig.shared.region).build()
        let _ = CometChat(appId: CCPConfig.shared.appId,appSettings: mySettings,onSuccess: { (isSuccess) in
        if (isSuccess) {
            print("Chat intialized successfully.")
        }}){ (error) in
            print("CometChat failed intialise with error: \(error.errorDescription)")
        }
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





/// Extension for all push notification related functions
extension AppDelegate {

    // Presents the notification banner when user is in the app
    func userNotificationCenter(_ center: UNUserNotificationCenter,willPresent notification: UNNotification, withCompletionHandler completionHandler:@escaping (UNNotificationPresentationOptions) -> Void) {
        print("\n\nForeground message recieved\n\n")
        print(notification)
        print("current call delegate: \(CometChat.calldelegate)")
        // commented to ignore
        completionHandler(.alert)
    }

    func application (_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
        print("device did register for push notifications")
        // Firebase Config
        Messaging.messaging().apnsToken = deviceToken
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
      print("Unable to register for remote notifications: \(error.localizedDescription)")
    }

    // Handles remote notifications in background,
    // also handles user responses to notifications, like tapping on them, in fore and background
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("\n\nUser tapped on notification \n\n")
        // Firebase Config
        Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

        // Print full message.
        print(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }

    //Send notification status when app is opened by clicking notifications
       func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print("\n\nUser tapped on notification\n\n")
        // Firebase Config
        Messaging.messaging().appDidReceiveMessage(userInfo)
    }
}

/// Firebase Cloud Messagin functions
extension AppDelegate: MessagingDelegate
{
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
      print("Firebase registration token: \(fcmToken)")

      let dataDict:[String: String] = ["token": fcmToken]
      NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
}
