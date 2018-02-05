//
//  LoginViewController.swift
//  BashtaBlog
//
//  Created by Andrey Bashta on 2/3/18.
//  Copyright © 2018 Andrey Bashta. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private var presenter = AuthorizePresener()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPostsList" {
            if let destination = segue.destination as? UINavigationController {
                destination.popToRootViewController(animated: true)
            }
        }
    }

    @IBAction func loginUser(_ sender: Any) {
        loginUser()
        performSegue(withIdentifier: "ShowPostsList", sender: nil)
    }
    
}

extension LoginViewController: AuthorizeView {
    
    func loginUser() {
        presenter.loginUser()
    }
    
    func logoutUser() {
        presenter.logoutUser()
    }
    
}
