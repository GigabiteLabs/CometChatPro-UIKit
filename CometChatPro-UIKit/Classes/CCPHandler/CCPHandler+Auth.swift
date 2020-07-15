// CCPHandler+Auth.swift
//
// Created by GigabiteLabs on 7/11/20
// Swift Version: 5.0
// Copyright © 2020 GigabiteLabs. All rights reserved.
//

import Foundation
import CometChatPro

public extension CCPHandler {

    func login(user: CCPUser, completion: @escaping (Bool) -> Void){
        print("attempting to login user for id: \(user.uid), name: \(user.firstname), lastname: \(user.lastname)")
        CometChat.login(UID: user.uid, apiKey: CCPConfig.shared.apiKey, onSuccess: { (userResponse) in
            print("CCP Messenger login was successful.")
            // Subscribe to comet chat push notifications through Firebase
            let userTopic = "\(CCPConfig.shared.appId)_user_\(user.uid.lowercased())_ios"
            //self.subscribeTo(topic: userTopic)
            //self.subscribeToGroupNotifications()
            completion(true)
        }, onError: { (exception) in
            switch exception.errorCode {
            case "ERR_UID_NOT_FOUND":
                self.createUser(user, immediateLogin: true) { (success) in
                    switch success {
                    case true:
                        CCPConfig.userLoggedIn = success
                        completion(true)
                    case false:
                        completion(false)
                    }
                    
                }
            default:
                print("error, CometChat login failed with exception: \(exception.errorDescription)")
                completion(false)
            }
        })
    }
    
//    func subscribeToGroupNotifications() {
//        // Unsubscribe from all groups
//        CometChat.getJoinedGroups(onSuccess: { (groups) in
//            for group in groups {
//
//                let groupString = "\(CCPConfig.shared.appId)_group_\(group.lowercased())_ios"
//                self.subscribeTo(topic: groupString)
//            }
//            print("finished group subscriptions")
//        }) { (error) in
//            print("there was an error: \(error?.errorDescription ?? "NO ERROR DESCRIPTION")")
//        }
//    }

    func logout() {
        print("attempting CometChat logout")
        let user = CometChat.getLoggedInUser()
        if let ccUser = user {
            // Unsubscribe from all groups
            print("attempting unsubscribe from all groups")
            CometChat.getJoinedGroups(onSuccess: { (groups) in
                for group in groups {
                    let groupString = "\(CCPConfig.shared.appId)_group_\(group.lowercased())_ios"
                    //self.unSubscribe(topic: groupString)
                }
                self.processLogout()
            }) { (error) in
                print("there was an error: \(error?.errorDescription ?? "NO ERROR DESCRIPTION")")
                self.processLogout()
            }
            // Unsubscribe from personal messages
            guard let uid = ccUser.uid?.lowercased() else {
                return
            }
            //unSubscribe(topic: "\(CCPConfig.shared.appId)_user_\(uid)_ios")
        }else{
            processLogout()
        }
    }

    private func processLogout() {
        CometChat.logout(onSuccess: { (response) in
          // Logout success
            print("user logged out of CometChat, response: \(response)")
        }) { (error) in
          // Logout error
            print("CometChat logout failed with error: \(error)")
        }
    }
}
