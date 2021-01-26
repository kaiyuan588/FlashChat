//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
//    let text = "⚡️FlashChat"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        showAnimation()
        titleLabel.text = "⚡️FlashChat"
    }
//    func showAnimation(){
//        titleLabel.text = ""
//        var interval = 0.0
//        for char in text {
//            Timer.scheduledTimer(withTimeInterval: 0.1 * interval, repeats: false) { (timer) in
//                self.titleLabel.text?.append(char)
//            }
//            interval += 1
//        }
//    }
    

}
