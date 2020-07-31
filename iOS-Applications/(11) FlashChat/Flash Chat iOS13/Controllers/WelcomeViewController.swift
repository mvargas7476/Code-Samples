//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Matias Vargas on 21/10/2019.
//  Copyright © 2019 Brewery App. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = ""
        let titleText = K.appName
        
        let timerConstant = 0.1
        var charIndex = 0
        
        for letter in titleText {
            // This uses a timer to show all of the letters on the title using a closure
            Timer.scheduledTimer(withTimeInterval: timerConstant * Double(charIndex), repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)

            }
            charIndex += 1
        }
    }
}
