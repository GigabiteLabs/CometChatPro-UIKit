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

    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presentCometChatPro(.fullScreen, animated: true) {
            print("presented comet chat pro")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

