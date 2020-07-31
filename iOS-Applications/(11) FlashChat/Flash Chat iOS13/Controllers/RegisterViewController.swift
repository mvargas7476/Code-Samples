//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Matias Vargas on 21/10/2019.
//  Copyright © 2019 Brewery App. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text {
        
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    //Make this a pop up so that you can learn how to do this
                    print(e.localizedDescription)
                } else {
                    //Navigate to the chat controller
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                    
                }
            }
        }
    }
}
