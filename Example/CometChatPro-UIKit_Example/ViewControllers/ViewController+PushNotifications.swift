// ViewController+PushNotifications.swift
//
// Created by GigabiteLabs
// Swift Version: 5.0
// Copyright © 2020 GigabiteLabs. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
 
    func requestNotificationAuthorization(pushAuthorized: @escaping (Bool) -> Void) {
        DispatchQueue.main.async {
            self.handlePNPermissions(application: UIApplication.shared) { (success) in
                switch success {
                case true:
                    pushAuthorized(true)
                case false:
                    print("push notifications have not been authorized by user, prompting user to address in iOS settings")
                    self.presentConfirmationAlert(title: "Push Notifications Not Authorized",
                                                        message: "Tap confirm to open settings now, or cancel and we'll remind you again in the future.") { (confirmed) in
                        switch confirmed {
                        case true:
                            print("user confirmed to open iOS settings")
                            
                        case false:
                            print("user declined to setup push notifications")
                           pushAuthorized(false)
                        }
                    }
                }
            }
        }
    }

    private func handlePNPermissions(application: UIApplication, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.async {
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                switch settings.authorizationStatus {
                case .denied:
                    print("push notification authorization denied")
                    completion(false)
                case .notDetermined:
                    let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                    UNUserNotificationCenter.current().requestAuthorization(
                        options: authOptions,
                        completionHandler: {_, _ in
                            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                                switch settings.authorizationStatus {
                                case .authorized:
                                    print("push notifications authorized by user")
                                    DispatchQueue.main.async {
                                        application.registerForRemoteNotifications()
                                    }
                                    completion(true)
                                case .denied:
                                    print("push notifications denied")
                                    completion(false)
                                case .notDetermined:
                                    print("something went wrong here")
                                    completion(false)
                                case .provisional:
                                    print("granted provisional authorization")
                                    completion(true)
                                default:
                                    print("something went wrong during push authorization")
                                    completion(false)
                                }
                            }
                    })
                case .provisional:
                    print("push notification authorization is provisional(?)")
                    completion(true)
                default:
                    print("push notifications authorized")
                    completion(true)
                }
            }
        }
    }
    public func presentConfirmationAlert(title: String, message: String, completion: @escaping (Bool) -> Void) {
        print("presentConfirmationAlert called")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { _ in
            completion(true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { _ in
            completion(false)
        }))
        present(alert, animated: true, completion: nil)
    }
    
}
