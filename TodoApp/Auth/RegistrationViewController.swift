//
//  RegistrationViewController.swift
//  TodoApp
//
//  Created by doniyor normuxammedov on 28/02/24.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class RegistrationViewController: UITableViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func registrationPressed(_ sender: Any) {
        if let email = emailTF.text , let password = passwordTF.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                }else {
                    self.shouldPerformSegue(withIdentifier: "RegistrationToAllList", sender: self)
                }
            }
        }
    }
}
