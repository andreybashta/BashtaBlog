//
//  LoginViewController.swift
//  BashtaBlog
//
//  Created by Andrey Bashta on 2/3/18.
//  Copyright © 2018 Andrey Bashta. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func login(_ sender: Any) {
        
        performSegue(withIdentifier: "ShowPostList", sender: nil)
        
//        let username = usernameField.text
//        let password = passwordField.text
//
//        guard (username == "" || password == "") else { return }
//        doLogin(username!, password!)
        
    }
    
    func doLogin(_ username: String, _ password: String) {
        
    }
    
}
