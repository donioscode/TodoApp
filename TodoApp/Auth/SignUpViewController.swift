//
//  SignUpViewController.swift
//  TodoApp
//
//  Created by doniyor normuxammedov on 01/03/24.
//

import UIKit
import FirebaseAuth
class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        if let email = emailTF.text, let password = passwordTF.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                    self.performSegue(withIdentifier: "SignUpToAllListvc", sender: self)
                }
            }
        }
    }
}
