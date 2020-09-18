//
//  ViewController.swift
//  CCPMessenger
//
//  Created by DanBurkhardt on 07/11/2020.
//  Copyright (c) 2020 DanBurkhardt. All rights reserved.
//

import UIKit
import UserNotifications
import CometChatPro_UIKit
#if DEBUG
import Bagel
#endif

class ViewController: UIViewController {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var submit: UIButton!
    
    let defaultMessage = "Enter your first & last names, and a simple (non-secure) password to login."
    
    @IBAction func launch(_ sender: Any) {
        getInput()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        #if DEBUG
        Bagel.start()
        #endif
        logo.clipsToBounds = true
        logo.layer.cornerRadius = logo.bounds.height / 2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        registerForNotifications()
        checkLocal()
    }
    
    func getInput() {
        guard let first = firstName.text, !first.isEmpty else {
            message.text = "first name cannot be blank."
            return
        }
        guard let last = lastName.text, !last.isEmpty else {
            message.text = "last name cannot be blank."
            return
        }
        guard let pass = password.text, !pass.isEmpty else {
            message.text = "password cannot be blank. if you made an account before, use the same pass. DO NOT use a password you use somewhere else."
            return
        }
        DispatchQueue.main.async {
            self.activity.startAnimating()
            self.submit.isHidden = true
        }
        // interpolate the info as a make-shift auth. high sec not
        // really needed in this demo app
        launch(first: first, last: last, uuid: "\(first)-\(pass)-\(last)".lowercased())
    }
    
    func checkLocal() {
        guard
            let first = UserDefaults.standard.string(forKey: "first"),
            let last = UserDefaults.standard.string(forKey: "last"),
            let uuid = UserDefaults.standard.string(forKey: "uuid")
        else {
            message.text = defaultMessage
            firstName.isHidden = false
            lastName.isHidden = false
            password.isHidden = false
            submit.isHidden = false
            activity.stopAnimating()
            return
        }
        message.text = "Login found. Starting messsenger..."
        launch(first: first, last: last, uuid: uuid)
    }
    
    func launch(first: String, last: String, uuid: String) {
        let user: CCPUser = .init(firstname: first, lastname: last, uid: uuid) // 1
        CCPHandler.shared.login(user: user) { (success) in  // 2
            self.presentCometChatPro(.fullScreen, animated: true, completion: nil) // 3
        } // 4
    }
    
    func saveLocal(first: String, last: String, uuid: String) {
        UserDefaults.standard.set(first, forKey: "first")
        UserDefaults.standard.set(last, forKey: "last")
        UserDefaults.standard.set(uuid, forKey: "uuid")
    }
    
    func reset() {
        DispatchQueue.main.async {
            self.firstName.isHidden = false
            self.lastName.isHidden = false
            self.password.isHidden = false
            self.activity.stopAnimating()
            self.message.text = self.defaultMessage
            self.submit.isHidden = true
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
                } else {
                    self.presentConfirmationAlert(title: "Push Notifications Disabled", message: "Push notifications are currently disabled, which means you won't be notified about new chats & calls. Tap ok to open settings to enable Push Notifications.") { (confirmed) in
                        if confirmed {
                            if let bundleId = Bundle.main.bundleIdentifier,
                                let url = URL(string: "\(UIApplicationOpenSettingsURLString)&path=LOCATION/\(bundleId)")
                            {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        }
                    }
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
