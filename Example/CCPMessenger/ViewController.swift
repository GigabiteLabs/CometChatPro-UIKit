//
//  ViewController.swift
//  CCPMessenger
//
//  Created by DanBurkhardt on 07/11/2020.
//  Copyright (c) 2020 DanBurkhardt. All rights reserved.
//

import UIKit
import CCPMessenger

class ViewController: UIViewController {

    @IBAction func launch(_ sender: Any) {
        presentCometChatPro(nil, animated: true) {
            print("presented comet chat pro")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

