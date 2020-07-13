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
        let cc: CometChatUnified = .init(nibName: nil, bundle: CCPType.bundle)
        cc.setup(withStyle: .formSheet)
        present(cc, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        let bundle = CCPType.bundle.bundleIdentifier
//        print("bundle identifier: \(bundle)")
//        print("bundle path: \(CCPType.bundle.bundlePath)")
        UIFont.loadAllFonts(bundleIdentifierString: CCPType.bundleId)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

